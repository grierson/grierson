# Events

Typical business process

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

## Resilience

> [!WARNING]
> What happens if any step fails?
> `place order`, `payment`, `ship`, or `send confirmation` can each fail

```mermaid
flowchart LR
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
        style D fill:#FF6961
    end
```

What happens if `email confirmation` fails?
We can't retry the entire process again as that would create multiple orders,
charging the customer twice.

Instead by exposing `events` between each step we `decouple` everything.
If any step fails we can retry it independently.

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

`Events` isolate steps from each other (Creating save points between each step).
Now if the `email confirmation` fails we can retry from the `order shipped` event
and retry sending the email again.

## Extensibility

Now we need to add a referral program, adding a `finders fee` for each purchase.
So we need to update and reploy our current implementation

```mermaid
flowchart LR
    style E fill:#AFE1AF
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
        B --> E[Finder's Fee]
    end
```

Instead by using `events` we can extend our system without changing our
current implementation.
We can add a new `finder’s fee` step that subscribes to the
`payment processed` event.

```mermaid
flowchart LR
    subgraph Process
        B[Process Payment]
        style be fill:#FFA500
        B --> be[Payment Processed]
    end
    subgraph Process1
        be -- "Subscribes" --> p1PP[Ship order]
    end
    subgraph Process2
        style p2ff fill:#AFE1AF
        be -- "Subscribes" --> p2ff[Finders Fee]
    end
```

## Scalability + Availability

> [!WARNING]
> What happens if the email process is overwhelmed with requests

The orginal process would require scaling vertically to match demand.

Instead by exposing events it's allows scaling horizontally by adding more subscribers.
So if the `email` step is slow we can add more `email consumers`.

```mermaid
flowchart TB
    subgraph Instance1
        A[Place Order] --> B[Process Payment]
        B[Process Payment] --> SO[Shipping Service]
        style C fill:#FFA500
        SO --> C[Shipped Order]
    end
    subgraph Email System
        C --> CG[Consumer Group]
        CG --> EC1[Email Confirmation 1]
        CG --> EC2[Email Confirmation 2]
        CG --> EC3[Email Confirmation 3]
    end
```

## Outbox pattern

A simplistic event driven architecture.

```mermaid
sequenceDiagram
    participant Application
    participant Consumer
    Application->>Application: Take payment
    Application->>Consumer: Publish Payment Received Event
```

> [!WARNING]
> What happens if `Take payments` fails but pubish the `Payment Received` event?
> [!WARNING]
> what happens if `Take payment` succeeds but don't publish the `Payment Received` event?

Both `Command` and `Store event` should be performed within a transaction,
and only committed if both processes succeed to prevent any inconsistencies.

The `Producer` should store any `events` it produces so that it can continue
to run even if consumers are down and unable to accept `events`.
`Consumers` can catch up and process the `events` when they are ready.

```mermaid
sequenceDiagram
    participant Application
    participant Database
    participant Publisher
    participant Consumer
    critical Transaction
      Application->>Database: Start transaction
      Application->>Application: Take payment
      Application->>Database: Store Payment Received Event
      Application->>Database: Commit transaction
    end
    loop Periodically check for new events
      Publisher->>Database: Read Events
    end
    Consumer->>Publisher: Handle Event
```
