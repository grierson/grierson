# Versioning

Encapsulation, Information hiding, Easing/Strengthening of requirements.

## Requiring more

Your `service` requires `user` data and is used by multiple clients.

```mermaid
flowchart LR
  subgraph Service
      user
  end
  Client1 --> Service
  Client2 --> Service
  ClientN --> Service
```

You then add a required `cart` field to your `service` so you can record the users shopping intests.
Only to discover you've broken all existing clients as they don't provide a `cart`.

```mermaid
flowchart LR
  subgraph Service
      direction TB
      user
      cart
  end
  style cart fill:#CFFDBC
  style Client1 fill:#FF6961
  style Client2 fill:#FF6961
  style ClientN fill:#FF6961
  Client1 --> Service
  Client2 --> Service
  ClientN --> Service
```

## Returning less

You current expose `user` and `cart` data which is used by multiple clients.

```mermaid
flowchart RL
  subgraph Service
        direction TB
        user
        cart
  end
  Consumer1 --> user
  Consumer1 --> cart
  Consumer2 --> user
```

If updated the `service` to now only return the `user` then clients that depended on it would break.

```mermaid
flowchart RL
  subgraph Service
        direction TB
        user
        cart
  end
  Consumer1 --> user
  Consumer1 --> cart
  Consumer2 --> user
  style Consumer1 fill:#FF6961
  style cart fill:#FF6961
```

> [!WARNING]
> The more points you expose the more points clients have to create dependencies to your system, so you need to think carfully about what you expose.

## Solution: Expand and Contact : Require more/different

Update `consumers` to provide the new/modified data.
Update `sevice` to consume the new data and remove the old data.
Go back and remove the old data from `consumers`.

## Solution: Expand and Contact : Return different

Update the `service` to accept either old/new data.
Update `consumers` to provide the new data.
Then go back and remove the old data from consumers and support of old data on the `service`.

## Resource

- https://www.youtube.com/watch?v#YR5WdGrpoug[Maybe Not - Rich Hickey]
