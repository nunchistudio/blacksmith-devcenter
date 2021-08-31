---
title: blacksmith namespaces update
enterprise: false
---

# `blacksmith namespaces update`

This command updates an existing namespace.

**Example:**
```bash
$ blacksmith namespaces update \
  --name customer_name \
  --email janedoe@example.com

Managing namespaces:

  -> Updating namespace customer_name...
     Success!
```

## Required flags

- `--name [namespace]`: The name of the namespace to update.

  **Aliases:** `-n [namespace]`

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --retention 48h
  ```

## Optional flags

- `--retention [duration]`: The new retention period to apply to the namespace.
  The minimum value for the `default` namespace is `24h`, and `5m` for the others.

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --retention 48h
  ```

- `--email [email]`: The new email address of the namespace's owner.

  **Example:**
  ```bash
  $ blacksmith namespaces create \
    --name customer_name \
    --email janedoe@example.com
  ```
