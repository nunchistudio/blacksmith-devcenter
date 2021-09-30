---
title: Deployment
enterprise: false
---

# Deployment

This guide focuses on server's networking, as it is useful regardless the container
or orchestration tool you use.

Under the hood, the Blacksmith server is [a Temporal
server](https://docs.temporal.io/docs/content/what-is-a-temporal-cluster/). It
exposes ports as follow:
- Service `frontend`: `7200` for gRPC, `7300` for membership
- Service `matching`: `7201` for gRPC, `7301` for membership
- Service `history`: `7202` for gRPC, `7302` for membership
- Service `worker`: `7203` for gRPC, `7303` for membership

Only the `frontend` port for gRPC `7200` shall be exposed to the public.

`network` options can be set for the `server`:
```yaml
server:
  network:
    bind_on: "0.0.0.0"
    broadcast_on: "172.18.0.1"
```

Where options are:
- `bind_on`: Address used to bind the server on specific IP address (eg. `0.0.0.0`).
  Only IP v4 is supported.
- `broadcast_on`: Address that is communicated to remote nodes to connect on.
  This is generally used when `bind_on` would be the same across several nodes
  (ie: `0.0.0.0`) and for NAT traversal scenarios. Only IP v4 is supported.
