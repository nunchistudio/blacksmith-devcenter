---
title: Your first migration
enterprise: false
---

# Your first migration

## Configuring the SQL integration

In the integration previously created, we can add a `migrations` key and a policy
dedicated to migration management:
```yml
sql:
  - name: "warehouse"
    # ...
    policies:
      # ...
      migration:
        path: "./warehouse/migrations"
        timeout: 20
      operation:
        timeout: 20
```

`path` represents the path to the directory where all migrations files for this
integration are stored. The `timeout` (in seconds) is the maximum time of a single
migration execution. This timeout should be as short as the longest possible
execution of a migration or an operation.

## Generating a new migration

The CLI provides a convenient way to generate migration files:
```bash
$ blacksmith generate migrations \
  --name init \
  --path ./warehouse/migrations
```

This generates the `up` and `down` files including the current timestamp and the
slugified name of the migration.

Since we need a table `users` with an `id` and `username`, the `up` direction
would be:
```sql
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  username TEXT UNIQUE NOT NULL
);
```

And the `down` direction would be:
```sql
DROP TABLE IF EXISTS users;
```

## Running the migration

You can check the migrations' status by running:
```bash
$ blacksmith migrations status \
  -i warehouse

1 migration to run for warehouse:
  - 20210802110000.init.up.sql (new)
```

Here you can witness that a new migration needs to run for the `warehouse`
integration.

We are able to run the migration with:
```bash
$ blacksmith migrations run \
  -i warehouse

1 migration to run for warehouse:
  - 20210802110000.init.up.sql (new)

Blacksmith will run the migrations as shown above. Do you confirm?
Only 'yes' will be accepted to confirm.
> yes

Executing migrations:

  -> Executing 20210802110000.init.up.sql...
     Success!
```

You can verify the new migrations' status by running:
```bash
$ blacksmith migrations status \
  -i warehouse

Latest migration:
  20210802110000.init.up.sql (applied)

No migrations to run.
```

Now that the gateway and database are both ready, the flow from **E**xtraction
to **L**oading can be triggered.
