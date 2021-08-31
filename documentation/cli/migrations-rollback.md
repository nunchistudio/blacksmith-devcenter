---
title: blacksmith migrations rollback
enterprise: false
---

# `blacksmith migrations rollback`

This command roll backs previously run migrations by executing their `down` logic.

**Example:**
```bash
$ blacksmith migrations rollback \
  --integration warehouse \
  --version 20210422135835

2 migrations to roll back for warehouse:
  - 20210422140548.fix_userid_pk.down.sql (applied)
  - 20210422135835.init.down.sql (applied)

Blacksmith will roll back the migrations as shown above. Do you confirm?
Only 'yes' will be accepted to confirm.
> yes

Executing migrations:

  -> Executing 20210422140548.fix_userid_pk.down.sql...
     Success!

  -> Executing 20210422135835.init.down.sql...
     Success!
```

## Required flags

- `--integration [integration]`: Integration to rollback the migrations for. In
  the following example, the migrations previously run for the integration
  `warehouse` will be rollbacked, until the version `20210422135835` is reached
  (including).

  **Aliases:** `-i [integration]`

  **Example:**
  ```bash
  $ blacksmith migrations rollback \
    --integration warehouse \
    --version 20210422135835
  ```

- `--version [time]`: Time representation down to which the migrations shall be
  rollbacked. In the following example, every migrations previously run down to
  the version `20210422135835` will be rollbacked, ordered by version from
  newest to oldest.

  **Aliases:** `-v [time]`

  **Example:**
  ```bash
  $ blacksmith migrations rollback \
    --integration warehouse \
    --version 20210422135835
  ```

## Optional flags

- `--discard`: Mark the migrations down to the specified version as `discarded`.
  Whereas a rollbacked migration can run again when the `run` command is executed,
  a discarded migration will not. In the following example, every migrations down
  to the version `20210422135835` will be discarded, meaning their `up` logic
  can not be executed again.

  **Aliases:** `-d`

  **Example:**
  ```bash
  $ blacksmith migrations rollback \
    --integration warehouse \
    --version 20210422135835 \
    --discard
  ```
