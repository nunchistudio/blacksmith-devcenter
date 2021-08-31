---
title: Handling multi-tenancy
enterprise: true
---

# Handling multi-tenancy

Namespaces are useful for isolation. The main use case is isolation *by tenant*
(multi-tenancy) when you wish to have dedicated resources and policies for each
team or customer.

This can be accomplished within a mono or across multiple repositories, depending
on your organizational requirements. Either way, you will end up with multiple
directories with one dedicated to the server, and with each other containing the
required files for a namespace.

The following structure is the recommended one for handling multi-tenancy:
- `./server`
  - `.env`, `.env.BLACKSMITH_ENV`
  - `/BLACKSMITH_DIR`
    - `services.BLACKSMITH_EXT` for `server`'s config.
- `./any-namespace`
  - `.env`, `.env.BLACKSMITH_ENV`
  - `/BLACKSMITH_DIR`
    - `services.BLACKSMITH_EXT` for `workers` and `gateway`'s config.
    - `integrations.BLACKSMITH_EXT` for integrations related to the namespace
      `any-namespace`.
    - `/gateway/*.BLACKSMITH_EXT` for the gateway's sources / triggers of the
      namespace `any-namespace`.

This way, a `server` directory is common for all namespaces and can be public or
private. Also, each team / customer has its own repository which can be public or
private as well.

For better consistency across teams inside an organization, we strongly advise
to always use the same `BLACKSMITH_DIR` and `BLACKSMITH_EXT` across directories
/ repositories.
