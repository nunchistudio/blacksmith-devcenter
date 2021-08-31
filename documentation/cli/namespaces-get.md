---
title: blacksmith namespaces get
enterprise: false
---

# `blacksmith namespaces get`

This command outputs information about a namespace.

**Example:**
```bash
$ blacksmith namespaces update \
  --name customer_name

Managing namespaces:

  -> Finding namespace customer_name...
     Name: customer_name
     Retention: 48h0m0s
     Owner: janedoe@example.com
```

## Required flags

- `--name [namespace]`: The name of the namespace to retrieve.

  **Aliases:** `-n [namespace]`

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name
  ```
