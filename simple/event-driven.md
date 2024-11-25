# Events

Typical single process

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
> What happens if any of these steps fail?
> As `place order`, `payment`, `ship`, or `send confirmation` could all fail.

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
We can't retry as that would create multiple orders and the customer would
be charged twice.

Instead decoupling each step from each other with `events` means we can retry
each independently? so if any one steps fails we can retry that independently.

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

Our current shipping process.

```mermaid
flowchart LR
    subgraph Process
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
    end
```

We add a referral program, adding a `finders fee` for each purchase.
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
        be --> p1PP[Ship order]
    end
    subgraph Process2
        style p2ff fill:#AFE1AF
        be --> p2ff[Finders Fee]
    end
```

## Scalability

Our current shipping process.

```mermaid
flowchart TB
    subgraph Instance
        A[Place Order] --> B[Process Payment]
        B --> C[Ship Order]
        C --> D[Email Confirmation]
    end
```

It also allows us to scale each step independently.
The current implementation requires scaling vertically whereas
with `events` we can scale horizontally.
So for example if the `email` step is slow we can scale that independently.

```mermaid
flowchart TB
    subgraph Instance1
        A[Place Order] --> B[Process Payment]
        B[Process Payment] --> SO[Shipping Service]
        style C fill:#FFA500
        SO --> C[Shipped Order]
    end
    subgraph EmailGroup
        C --> EC1[Email Confirmation 1]
        C --> EC2[Email Confirmation 2]
        C --> EC3[Email Confirmation 3]
    end
```
