---
title: blacksmith migrations status
enterprise: false
---

# `blacksmith migrations status`

This command outputs the status of migrations for a given integration.

**Example:**
```bash
$ blacksmith migrations status \
  --integration warehouse

2 migrations to run for warehouse:
  - 20210422135835.init.down.sql (rolled back)
  - 20210422140548.fix_userid_pk.down.sql (rolled back)
```

## Required flags

- `--integration [integration]`: Integration to output the migrations' status
  for. In the following example, the migrations' status for the integration 
  `warehouse` will be displayed.

  **Aliases:** `-i [integration]`

  **Example:**
  ```bash
  $ blacksmith migrations status \
    --integration warehouse
  ```
