# (WIP) Structure
<!-- mtoc-start -->

* [Pure code](#pure-code)
  * [Pure code examples](#pure-code-examples)
  * [Why pure code](#why-pure-code)
* [Impure code](#impure-code)
  * [Impure code examples](#impure-code-examples)
  * [Why impure code](#why-impure-code)
* [Maximise `Pure` and Minimise `Impure`](#maximise-pure-and-minimise-impure)
* [Move details to edge (Port and Adapters, Persistence ignorance)](#move-details-to-edge-port-and-adapters-persistence-ignorance)
  * [Persistence ignorance](#persistence-ignorance)
  * [Testing](#testing)
* [Why Pure and Impure](#why-pure-and-impure)
* [References](#references)
* [Feature Cohesion](#feature-cohesion)
  * [Feature Cohesion Examples](#feature-cohesion-examples)
* [Glossary](#glossary)

<!-- mtoc-end -->

## Pure code

`Pure` = Deterministic (Same input, Same output)

```mermaid
flowchart LR
  style Add fill:ForestGreen
  Addend1 --> Add
  Addend2 --> Add
  Add --> Sum
```

### Pure code examples

* `add(int int) => int` - Given the same input you will always receive the same output
* `addItem(cart item) => cart` - Item might be added depending logic but it's consistent

### Why pure code

* Deterministic - Same Input, Same output. Doesn't matter when call is made
* Easy to test - No `Stubs`/`Mocks` required, just data for input.

## Impure code

`Impure` = Non-deterministic (Might have input, Might have output)

```mermaid
---
title: Today's call
---
flowchart LR
  style Now fill:FireBrick
  Now["now()"] --> 27/01/2017
```

```mermaid
---
title: Tomorrow's call
---
flowchart LR
  style Now fill:FireBrick
  Now["now()"] --> 20/01/2021
```

### Impure code examples

* Function is `stateful` like a counter
  * `counter() -> 1`
  * `counter() -> 2`
  * `counter() -> ...`
* Calling external service (I/O) like a Gateway
  * `paymentProvider.Pay(token, itemId)`
    * Provider **might** accept payment
      * Token could be expired
      * Account might have insufficient funds
      * Item might be out of stock
      * The payment provider is down
* Does additional steps within the function
  * `orderService.Update(order)`
    * Sends email in the middle of updating order
    * Updates stock in the Stock service

### Why impure code

We still need to interact with the real `impure` world, Like

* Sending emails
* Working with Database and Gateways

So things actually get done. `Pure` functions by themselves will
won't actually achieve anything usefully except heat up your room
as it runs on your computer.

## Maximise `Pure` and Minimise `Impure`

Maximise the amount of `Pure` code and minimise the amount of `Impure` code

* Harder to read as `Impure` specific code is mixed with `Pure` domain workflows.
  * Connecting to database
  * Establishing a secure connection with a gateway
* Difficult to change if you later swap `I/O`.
  * Yesterday we use Payment service `A`
  * Today Payment service `A` want 50% of every sale
  * Tomorrow we need to swap out every instance of `A` with `B`
* Difficult to test as `I/O` is called directly.
  * Our Payment service charges $1 for every call
  * We don't want to pay $1 to run tests
* Error prone, Can fail and have to handle exceptions.
  * Payment service could be down

```mermaid
flowchart LR
  style pure1 fill:ForestGreen
  style pure2 fill:ForestGreen
  style i/o1 fill:FireBrick
  style i/o2 fill:FireBrick
  style i/o3 fill:FireBrick
  i/o1[I/O] --> pure1[Pure] --> i/o2[I/O] --> pure2[Pure] --> i/o3[I/O]
```

```diff
function application() {
-    var randomNumber = Random.generate(1, 100);
-    var now = DateTime.Now;
+    var randomDay = now.AddDays(randomNumber);

+    if (now.DayOfWeek == randomDay.DayOfWeek)
-       Console.WriteLine("Correct");
+    else {
+       var daysOut = Math.Abs((int)now.DayOfWeek - (int)randomDay.DayOfWeek);
-       Console.WriteLine($"Wrong, out by {daysOut} days");
    }
} 
```

Instead separate `pure` code out so it's all in the middle. (Like a Sandwich).

Query the `Database`, perform `Pure` domain logic, save to `Database`

```mermaid
flowchart LR
  style pure1 fill:ForestGreen
  style i/o1 fill:FireBrick
  style i/o2 fill:FireBrick
  i/o1[I/O] --> pure1[Pure] --> i/o2[I/O]
```

Splitting out the `Pure` code makes it

* Easier to read as no `Impure` code required. (Database, Date.Now, File system)
  * No setup code for Database or making network calls
* Easier to test (No Console, Date.Now, File system, Gateway)
  * Just pass data in, no need to Stub/Mock `Impure` code
* Reuse `Pure` code in different contexts.
  * Use in another application which uses CLI input.
  * Then use it in another application which uses HATEOAS instead.
* No unexpected results
  * Deterministic
  * Same input, Same output

```diff
function check(now, randomOffset) {
+    var randomDay = now.AddDays(randomNumber);

+    if (now.DayOfWeek == randomDay.DayOfWeek)
+       return "Correct";
+    else {
+       var daysOut = Math.Abs((int)now.DayOfWeek - (int)randomDay.DayOfWeek);
+       return $"Wrong, out by {daysOut} days";
    }
}

function application() {
-    var randomNumber = Random.generate(1, 100);
-    var now = DateTime.Now;

+    var result = pure(now, randomNumber);

-   Console.WriteLine(result)
} 
```

## Move details to edge (Port and Adapters, Persistence ignorance)

Realistically you need to interact with outside `Impure` world
so you can actually get stuff done.

```mermaid
flowchart LR
  style Mixed fill:SaddleBrown
  style i/oIn fill:FireBrick
  style i/oOut fill:FireBrick
  subgraph Application
    Mixed
  end
  i/oIn[I/O] --> Mixed --> i/oOut[I/O] 
```

```c_sharp
public class Workflow {
  public void Handle(Guid customerId, List<Guid> productIds) {
    var database = new Database("connection-string");
    var customer = database.get(customerId); 

    var httpClient = new HttpClient();
    var raw_result = await httpClient.get("${productApi}?productIds=[productIds]");
    var products = raw_result.parse_products();
    
    var sum_products = products.reduce(product => product.price, 0);

    if (sum_products > customer.balance) {
      customer.balance -= sum_products;
      database.SaveChanges();
    } else {
      await EmailServer.Send(customer.Email, "Insufficient funds");
    }
  }
}
```

We have the problem of the interleaved `Pure` and `Impure` code.
But there's even more problems.

* It's hard to read what the function is even doing as there's so much code just
setting up our `Impure` code.
* What if the `products` API changes address or response data?
Now we need to update every instance of the api throughout our application
* How do we test this function?
Do we need to setup a Database and have access to payments API?
* It's non-deterministic?
  * What if the products API doesn't return all the products?
  * What if the price has changed?
  * What if the customer doesn't exist anymore?

This is where `Ports and Adapters` comes in.
We create `Adapters` that specifically handle `Impure` operations and pass
those into our `Pure` code (not pure now technically).

```mermaid
flowchart LR
  style Pure fill:ForestGreen
  style ShellIn fill:Indigo
  style ShellOut fill:Indigo
  style i/oIn fill:FireBrick
  style i/oOut fill:FireBrick
  subgraph Application
    ShellIn
    ShellOut
    Pure
  end
  i/oIn[I/O] --> ShellIn[Adapter] --> Pure 
  Pure[Pure] --> ShellOut[Adapter] --> i/oOut[I/O]
```

```c_sharp
public class Workflow(
  CustomerDatabase customerDatabase, 
  PaymentClient paymentClient
) {
  public Result<ProcessedOrder> Handle(Guid customerId, List<Guid> productIds) {
    var customer = await customreDatabase.get(customerId); 
    var products = await paymentClient.get(productIds);
    
    var result = UpdateBalance(customer, products);

    if (result != null) {
      await database.SaveChanges();
      return ProcessedOrder.Complete;
    } else {
      await EmailServer.Send(customer.Email, "Insufficient funds");
      return ProcessedOrder.Failed;
    }
  }

  private Customer? UpdateBalance(Customer customer, List<Product> products) {
    var sum_products = products.reduce(product => product.price, 0);

    if (sum_products > customer.balance) {
      customer.balance -= sum_products;
      return customer; 
    } else {
      return null;
    }
  }
}
```

Here the `CustomerDatabase` and `paymentClient` are both `Adapters`
abstracting how we deal with `Impure` code.
So it doesn't interfere with the main `Pure` domain workflow.

Fully fleshed out version below

```mermaid
flowchart LR
  subgraph Application
    style Domain fill:ForestGreen
    subgraph Domain
      IQuery
      ICommand
      INotify
      Usecase
    end
    style AdaptersIn fill:DarkOrchid
    subgraph AdaptersIn[Adapters In]
      ORM
      HATEOAS
    end
    style AdaptersOut fill:DarkOrchid
    subgraph AdaptersOut[Adapters Out]
      Gateway[Payment Gateway]
    end
  end
  style I/OIn fill:FireBrick
  subgraph I/OIn[I/O In]
    Database
    HTTP
  end
  style I/OOut fill:FireBrick
  subgraph I/OOut[I/O Out]
    ThirdParty[Payment Service]
  end
  HTTP --> HATEOAS
  Database --> ORM
  HATEOAS --> ICommand
  ORM --> IQuery
  IQuery --> Usecase
  ICommand --> Usecase
  Usecase --> INotify
  INotify --> Gateway
  Gateway --> ThirdParty
```

### Persistence ignorance

[TODO: WIP]

Don't want `HTTP` coming into `Pure`.
Don't want `Pure` know how to write to DB

### Testing

```mermaid
flowchart LR
  style Pure fill:ForestGreen
  style ShellIn fill:Indigo
  style ShellOut fill:Indigo
  subgraph Integration[Integration Test]
    ShellIn
    ShellOut
    subgraph Unit[Unit Test]
      Pure
    end
  end
  ShellIn[Adapter In] --> Pure 
  Pure[Pure Functional core] --> ShellOut[Adapter Out]
```

## Why Pure and Impure

> The overriding rule that makes this architecture work is The Dependency Rule.
> This rule says that source code dependencies can only point inwards.
> Nothing in an inner circle can know anything at all about
> something in an outer circle.
> [...]
> We don’t want anything in an outer circle to impact the inner circles.
>
> [Uncle Bob - The Clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
> [!NOTE]
> Test at the boundaries of a system. Not the internals.
> Tests should be done at the `workflow` level.
> `Unit` produces no side effects and runs in isolation

* Benefits
  * Framework agnostic
    * Can change `Adapters` out without changing `Domain`.
  * Testable
    * Can test `Domain` without `I/O` (Database, HTTP, Service)

## References

* [Moving IO to the edges of your app: Functional Core, Imperative Shell - Scott Wlaschin](https://www.youtube.com/watch?v=P1vES9AgfC4)
* [Functional core, Imperative shell - Gary Bernhardt](https://www.destroyallsoftware.com/screencasts/catalog/functional-core-imperative-shell)
* [Sandwich  architecture - Mark Seemann](https://blog.ploeh.dk/2023/10/09/whats-a-sandwich/)
* [Solving Problems the Clojure Way - Rafal Dittwald](https://www.youtube.com/watch?v=vK1DazRK_a0)
* [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
* [Port and Adapters - Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture/)

## Feature Cohesion

No

* Models/
* Controllers/
* Views/
* Services/

Yes

* Orders
  * Get/
    * handler.clj
    * spec.clj
  * Delete/
    * handler.clj
* Cart
  * cartAggregate.clj
  * AddItem/
    * handler.clj

### Feature Cohesion Examples

* Screaming Architecture
* Vertical Slice Architecture
* Modular Monolith

## Glossary

* Pure
  * Deterministic - Same input, Same output.
  * No side effects
* I/O (Input/Output)
  * Non-deterministic output, if any.
* Workflow / Use case / Story
  * Process that fulfils expected outcome
