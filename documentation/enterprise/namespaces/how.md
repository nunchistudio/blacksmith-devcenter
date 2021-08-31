---
title: How it works
enterprise: true
---

# How it works

Blacksmith Enterprise Editions brings support for managing multiple namespaces,
which allows *everything* to be segmented from other namespace of the cluster.

Namespaces are useful for isolation. The main use case is isolation *by tenant*
(multi-tenancy) when you wish to have dedicated resources and policies for each
team or customer.

Clients and workers are always related to a namespace. Whereas the server is
common for all namespaces of an organization, a worker is dedicated to a single
namespace. Therefore, if you want to leverage both the loader and operator workers
for 3 namespaces, you must have 6 running workers (or more for high availability).

Knowing this, we can now highlight the components specific to a single namespace,
that therefore are completely isolated from one namespace to another:
![Namespaces in Blacksmith](/images/blacksmith/how-namespaces.png)

## Notes about retention

Each namespace can have its own retention period. Blacksmith stores *everything*
per the configured retention. The retention is a duration in minutes or hours,
respectively suffixed by `m` or `h`. We voluntarily don't support longer intervals
because it can create a lot of confusion:
- *How long is a day or a month? Is the answer always the same?* It depends.
- *5 retention days, including weekends and / or holidays?* It depends.

This is why retention periods are always in minutes or hours. If you wish to
create a namespace with a retention of 14 days, multiply `24h` by `14`:
```bash
$ blacksmith namespaces create \
  --name default \
  --retention 336h
```

The minimum retention period for the `default` namespace is `24h`, and `5m` for
the others.

## Managing namespaces

You can [create](/blacksmith/cli/namespaces-create), [get](/blacksmith/cli/namespaces-get),
and [update](/blacksmith/cli/namespaces-update) namespaces via the CLI.
