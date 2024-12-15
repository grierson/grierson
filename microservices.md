# TL;DR Microservices

Microservices gives you options like in the examples below. However, it's not a
free lunch as other parts become more complicated (Deployment, Networking,
Observability, Reporting), so you need a reason to implement microservices.

## Overview

> If you take only one thing from this book and from the concept of
> microservices in general, it should be this: ensure that you embrace the
> concept of independent deployability of your microservices.
> - Sam Newman, Building Microservices 2nd Edition, 2019

A key feature of microservices is their independent deployability, allowing new
functionality to be built and deployed separately from other services in
contrast to monolithic architecture, which packages all functionality together
for development and deployment.

> They buy you options
> - James Lewis, Microservices Guide, 2014

* Organisation
* Technical
* Scale
* Robustness

## Organisational Autonomy

**Problem**: You recieve new requirements

**Microservice**: Teams can work independenly of each other without
coordination.

## Continuous Integration

**Problem**: You make a change and want to commit

**Monolith**: As everyone is working on the same codebase, it increases the the
likeliness of incurring merge conflicts.

**Microservices**: As development is spread across services, it reduces the
likelihood of merge conflicts.

> [!WARNING]
> Coupling the codebase increases merge conflicts

## Continuous Deployment

**Problem**: You make a change and want to deploy

**Monolith**: Requires redeploying the entire system, so you are deploying more
things that can go wrong, which may lead to longer release cycles.

**Microservices**: Deployments are much smaller and limit the scope of each
release. It also promotes zero downtime; if a deployment fails, only the service
fails, not the platform.

WARNING: Coupling features into release is more problematic

## Sensitive Data Governance

**Problem**: You are working with sensitive data

**Monolith**: As a monolith has access to everything, all features must conform
to a high level of governance even if it isn't required.

```mermaid
flowchart TD
    subgraph protection
      subgraph mono
        direction TB
        products
        cart
        checkout
      end
    end
    style protection fill:#AEC6CF
```

**Microservices**: Only a few services handle sensitive data, so they require a
higher level of protection, whereas most other services don't, so they don't
have to worry about those constraints.

```mermaid
flowchart TD
    subgraph protection
      user
    end
    products
    cart
    checkout
    style protection fill:#AEC6CF
```

> [!WARNING]
> Handling sensitive data in one process adds strict goverance constraints to
> everything even when it's not required

## Sensitive Data Breach

**Problem**: Hackers gain access your database

**Monolith**: All of you data is in one so hackers have access to everything

**Microservices**: As your databases a seperated out the hackers will only have
access to a small set of data

WARNING: One database breaches are more catastrophic

## Blash Radius

**Problem**: The checkout feature has crashed

**Monolith**: Checkout has crashed, taking the entire platform down with it.

```mermaid
flowchart LR
    subgraph mono
      products
      cart
      checkout
      style checkout fill:#FF6961
    end
    style mono fill:#FAA0A0
```

**Microservices**: The checkout service is down, but parts of your platform
still work; users can still view products, add products to their cart, and
manage previous orders, just not checkout.

```mermaid
flowchart TB
  products
  cart
  checkout
  style checkout fill:#FF6961
```

> [!WANRING]
> Everything in one process causes complete outages

## Scaling

**Problem**: You see an influx in demand for a product

**Monolith**: Scaling requires starting another instance of the Monolith to
scale when only the `product` component needs scaling. As in the example below,
we've also inadvertently scaled the `cart` module, even though we don't need to.

```mermaid
flowchart LR
    lb[Load balancer]
    subgraph mono-1
      products-1
      cart-1
    end
    subgraph mono-2
      products-2
      cart-2
      style cart-2 fill:#FF6961
    end
    subgraph mono-n
      products-n
      cart-n
      style cart-n fill:#FF6961
    end
    lb --> mono-1
    lb --> mono-2
    lb --> mono-n
```

**Microservices**: We scale only the `product service` as it's independent.

```mermaid
flowchart LR
    lb[Load balancer]
    subgraph product-service
      products-1
      products-2
    end
    lb --> product-service
```

> [!WARNING] 
> Coupling all functionality into one process causes inefficient scaling

## Technical debt

**Problem**: You want to use a new library however your Monolith is stuck on an
older runtime because some unrelated code that's not linked to the new piece of
work you need to do doesn't support the latest runtime.

**Monolith**: You either have to waste time fixing the legacy code to work with
the latest runtime or just drop using the new library you want to use. Either
option is slowing future development, preventing you from going to market
quicker and getting customer feedback.

**Microservices**: You are free to create a new service without any previous
technical debt and able to use whatever technology you like.

WARNING: One codebase adds constraints on future development

## Resources

- https://www.oreilly.com/library/view/building-microservices-2nd/9781492034018/[Building Microservices Second]
