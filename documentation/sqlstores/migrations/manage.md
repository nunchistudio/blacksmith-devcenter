---
title: Managing migrations
enterprise: false
---

# Managing migrations

## Running migrations

Once a migration is generated with the `generate` command, it can be run with:
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

You can also run migrations until a given version is reached (including):
```bash
$ blacksmith migrations run \
  --integration warehouse \
  --version 20210809135841

1 migration to run for warehouse:
  - 20210809135841.init.up.sql (new)

Blacksmith will run the migrations as shown above. Do you confirm?
Only 'yes' will be accepted to confirm.
> yes

Executing migrations:

  -> Executing 20210809135841.init.up.sql...
     Success!
```

Migrations are executed ordered by version from oldest to newest. If an error
occured while executing a migration, the others will not be executed. You first
need to fix the failing migration to be able to run it again along the others
awaiting to run.

## Rolling back migrations

Mistakes can happen. This is why you sometimes need to *rollback* a migration,
or a suite of migrations.

When rolling back, the `version` flag must be provided. All migrations will be
rolled back until the version is reached (including).

For example, to rollback every migrations down to the version `20210422135835`:
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

Migrations are rolled back ordered by version from newest to oldest. If an error
occured while rolling back a migration, the others will not be rolled back. You
first need to fix the failing migration to be able to roll it back again along
the others awaiting to be rolled back.

## Discarding migrations

When rolled back, a migration is not discarded. Which means you can still update
its `up` / `down` logic and try to run it again. However, if you need to discard
a migration once it is successfully rolled back, you can add the `--discard` flag
as follow:
```bash
$ blacksmith migrations rollback \
  --integration warehouse \
  --version 20200930071321 \
  --discard
```

This will mark the migration as `discarded` so it is not possible to run it again.

## Checking the status

Before running or rolling back migrations, we advise to always check the
migrations' status of the integration:
```bash
$ blacksmith migrations status \
  --integration warehouse

2 migrations to run for warehouse:
  - 20210422135835.init.up.sql (rolled back)
  - 20210422140548.fix_userid_pk.up.sql (rolled back)
```

Even though the `run` and `rollback` commands display the migrations that will
be executed and prompt a confirmation, this allows to be more confident and avoid
mistakes as much as possible.
