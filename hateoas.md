# Hypermedia as the Engine of Application State (HATEOAS)

> A REST client needs little to no prior knowledge about how to interact with an application or server beyond a generic understanding of hypermedia.
> The restrictions imposed by HATEOAS decouples client and server.
> This enables server functionality to evolve independently.
>
> - <https://htmx.org/essays/hateoas>

To demonstate I've created a strawman bank account response to demonstrate the benefits of HATEOAS.

```json
// Non-Hypermedia Bank account response
{
  "cardId": 123,
  "balance" 100,
}
```

## Location transparency

**Problem**: I would like to withdraw from my bank account

I check the API documentation (Swagger) and hard-code the URL into my REST client.

```clojure
(defn withdraw [accountId]
  (http/post
    "http://www.bank.com/account/" accountId "/withdraw"))
```

> [!WARNING]
> **coupling** the client and server as the URL is **hard coded** into the client

If the address changes e.g. a `v2` endpoint then the **client** also needs to be updated.

`HATEOAS` avoids this by having the server tell clients what the address is.

```json
// HATEOAS Bank account response
{
  ...
  "_links": {
    "withdraw": "http://www.bank.com/account/123/withdraw"
  }
}
```

Then clients' use the `withdraw` link instead of a hard-coded URL.

```clojure
(defn withdraw [accountId]
  (let [discovery (http/get "http://www.bank.com")]
    (http/post (get-in discovery [:_links :withdraw]))))
```

The `withdraw` URL can now change like in the `v2` example without breaking changes as we’ve added a layer of indirection via the links.
The server is telling the client what the URL is, not the client having out-of-band knowledge from the API docs.

## Resource references

**Problem**: What is `cardId`?

Say we need to create a new `Payment service` with a `/payment` resource that requires a `card` in order to check the balance.

A naive implementation would be to have the `/payment` resource take a `cardId`

```json
 {
   "card": 123
   ...
 }
```

```clojure
 (defn payment-resource [request]
   (let [card-id (:cardId request)
         card-url (str "http://www.bank.com/cards/" cardId)
         card (http/GET card-url)]
     (> 0 (:balance card))))
```

> [!WARNING]
> `Location transparency` issue if the URL changed.

Instead if `/payment` accepted a `card url` it can discover the `card` avoiding the `Location transparency` issue.

```json
{
  "card": "http://www.bank.com/cards/123"
}
```

```clojure
; HATEOAS Bank payment client
(defn payment-resource [request]
  (let [card-url (:card request)
        card (http/GET card-url)]
    (> 0 (:balance card))))
```

It also makes `/payment` resource extensible to new types.
For example `/payment` could support a new `crypto` resource in the future as long as a `balance` property exists.

```json
{
  "card": "http://www.bank.com/v2/crypto/123"
}
```

## Hypermedia controls

**Problem**: Can I withdraw?

If an account balance is 0 or below you can not withdraw.
So naïvely we add the withdrawal conditional logic to our client.

```javascript
if (response.balance > 0) return <button>withdraw</button>
```

> [!WARNING]
> **coupling** the client to business ruls as it knows about withdrawal conditional logic.
> Also it doesn't stop bad api calls.

Then business rules change and users can now withdraw into overdrafts.
Meaning updating the client, as well as multiple other clients we have created since. :sad face:

Instead HATEOAS returns links (actions) that you can perform on the resource.
Simplifying UIs by having one single source of truth for business logic which clients don't have to know about.

```javascript
// Without balance
{
  "balance": 0,
  "_links": {
    "deposit:" "/deposit/123"
  }
}
```

```javascript
// With balance
{
  "balance": 100,
  "_links": {
    "deposit:" "/deposit/456",
    "withdraw:" "/withdraw/456"
  }
}
```

So clients just check if the link exists.

```javascript
if (hateos/has-link response "withdraw")
  return <button>withdraw</button>
```

# References

- <https://htmx.org/essays/hateoas/[HATEOAS> by HTMX]
- <https://medium.com/kroo/how-kroo-maintains-sanity-in-distributed-systems-part-1-adad8cf095bf[How> Kroo maintains sanity in distributed systems — Part 1 By Jonas Svalin]
