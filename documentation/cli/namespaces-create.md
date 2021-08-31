---
title: blacksmith namespaces create
enterprise: false
---

# `blacksmith namespaces create`

This command creates a new namespace.

**Example:**
```bash
$ blacksmith namespaces create \
  --name default \
  --retention 48h

Managing namespaces:

  -> Creating namespace default...
     Success!
```

## Required flags

- `--name [namespace]`: The name of the namespace to create.

  **Aliases:** `-n [namespace]`

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --retention 48h
  ```

- `--retention [duration]`: The retention period to apply to the namespace. The
  minimum value for the `default` namespace is `24h`, and `5m` for the others.

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --retention 48h
  ```

## Optional flags

- `--email [email]`: The email address of the namespace's owner.

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --retention 336h \
    --email janedoe@example.com
  ```
