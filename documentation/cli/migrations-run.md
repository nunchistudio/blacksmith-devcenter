---
title: blacksmith migrations run
enterprise: false
---

# `blacksmith migrations run`

This command runs acknowledged migrations by executing their `up` logic.

**Example:**
```bash
$ blacksmith migrations run \
  --integration warehouse

1 migration to run for warehouse:
  - 20210809135841.init.up.sql (new)

Blacksmith will run the migrations as shown above. Do you confirm?
Only 'yes' will be accepted to confirm.
> yes

Executing migrations:

  -> Executing 20210809135841.init.up.sql...
     Success!
```

## Required flags

- `--integration [integration]`: Integration to run the migrations for. In the
  following example, the migrations for the integration `warehouse` will be run.

  **Aliases:** `-i [integration]`

  **Example:**
  ```bash
  $ blacksmith migrations run \
    --integration warehouse
  ```

## Optional flags

- `--version [time]`: Time representation up to which the migrations shall be
  run. In the following example, every migrations up to the version `20210422135835`
  (including) will be run, ordered by version from oldest to newest.

  **Aliases:** `-v [time]`

  **Example:**
  ```bash
  $ blacksmith migrations run \
    --integration warehouse \
    --version 20210422135835
  ```

- `--auto-approve`: Skip interactive approval before running migration(s). This
  option is useful for running migrations in a non-interactive environment, such
  as inside a CI / CD platform.

  **Example:**
  ```bash
  $ blacksmith migrations run \
    --integration warehouse \
    --auto-approve
  ```
