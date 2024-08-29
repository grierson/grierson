# WIP Events

An example of processing an order in a single process.

```mermaid
flowchart LR
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
    end
```
```clojure
(defn process [request]
    (-> request
        (place-order)
        (process-payment)
        (ship-order)
        (send-email)))
```

## What is an event?

An event is a notification that something has happened.
It is a record of an action that has taken place.
A fact.

## Resilience

> [!WARNING]
> What happens if any of these steps fail? As `place order`, `payment`, `ship`, or `send confirmation` could all fail.

```mermaid
flowchart LR
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
        style D fill:#FF6961
    end
```

What happens if sending the `email confirmation` fails? Do we retry? If we did then our system would have multiple `placed orders`, the customer would be `charged` twice, and we would `ship` multiple orders. Can we isolate each step from each other so that they can be retried independently? 

```mermaid
flowchart LR
    subgraph Process
        A[Place Order]
        B[Process Payment]
        C[Ship Order]
        D[Email Confirmation]
        style ae fill:#FFA500
        style be fill:#FFA500
        style ce fill:#FFA500
        style de fill:#FFA500
        A --> ae[Order Placed]
        ae --> B
        B --> be[Payment Processed]
        be --> C
        C --> ce[Order Shipped]
        ce --> D
        D --> de[Email Sent]
    end
```

Instead if we used `events` to communicate we isolate each step from each other, basically creating save points between each step. Now if the `email confirmation` fails we can retry from the `order shipped` event and retry sending the email again. |

## Extensibility

Now say we to add a referal programme and apply a `finders fee` for each purchase.
Currently we would need to update and reploy our current implementation

```mermaid
flowchart LR
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
        B --> E[Finder's Fee]
    end
```
```clojure
(defn process [request]
    (-> request
        (place-order)
        (process-payment)
        (fn [_]
            (ship-order)
            (finder-fee))
        (send-email)))
```
```mermaid
flowchart LR
    subgraph Process
        B[Process Payment]
        C[Ship Order]
        style be fill:#FFA500
        B --> be[Payment Processed]
        be --> C
        be --> D[Finders Fee]
    end
```
By using `events` we can extend our system without changing our current implementation. We can add a new `finder’s fee` step that subscribes to the `payment processed` event. |

## Scalability

It also allows us to scale each step independently.
The current implementation requires scaling vertically whereas with `events` we can scale horizontally.
So for example if the `process payment` step is slow we can scale that independently.
