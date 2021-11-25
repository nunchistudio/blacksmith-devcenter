---
title: How it works
enterprise: false
---

# How it works

Migrations add a convenient way to evolve your databases' schemas over time.
Blacksmith has a unique set of migration features making the experience as smooth
as possible for software and data engineers.

Migrations are isolated by integration. Each SQL database registered as an
integration can have its own migrations. By doing so, you can leverage the native
dialect of each one.

## Automatic mutex

When working with *operations* and *migrations*, Blacksmith automatically leverages
a remote mutex to ensure only one task at a time is being run against the same
integration within a namespace. This allows distributed teams to safely work
together with no access collisions.

If a user tries to run a task for an integration already in use, Blacksmith will
try to wait for the running task to complete and then process the next one. If
the timeout is reached, Blacksmith will return an error and the desired task shall
manually be run later. This is why a user may wait for a few seconds before seeing
their task actually running.

## Generating migrations

A migration can be generated with the `generate` command, as follow:
```bash
$ blacksmith generate migration \
  --name fix_userid_pk
```

This will generate the required files for a migration, inside the working directory.

If you prefer, you can generate a migration inside a directory with the `--path`
flag:
```bash
$ blacksmith generate migration \
  --name fix_userid_pk \
  --path ./warehouse/migrations
```

The generated file names should look like this:
- `20210422140548.fix_userid_pk.up.sql`
- `20210422140548.fix_userid_pk.down.sql`

A migration file has several properties, including:
- `Version`: The version number is a 14 length character holding the current
  timestamp, formatted with `YYYYMMDDHHMISS`.
  
  **Example:** `20210422140548`.

- `Name`: The slugify name of the migration.

  **Example:** `fix_userid_pk`.

- `Direction`: The direction of the run. It is either `up` or `down`.
