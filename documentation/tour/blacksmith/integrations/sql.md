---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "hello"
      description: |
        The connection string to use to connect to the SQL store.

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-sql-store"
      required: true
      description: |
        The name of the integration to register.

    - key: "driver"
      type: "string"
      required: true
      description: |
        The driver to leverage for working with a SQL database.

    - key: "connection"
      type: "string"
      required: true
      description: |
        The driver-specific connection string.

policies:
  migration:
    schema:
      - key: "path"
        type: "string"
        example: "./warehouse/migrations"
        required: true
        description: |
          Relative path for finding migrations of the integration.

      - key: "timeout"
        type: "integer"
        example: 45
        required: true
        description: |
          The maximum time (in seconds) of a single migration execution. This
          timeout should be as short as the longest possible execution of a
          migration.

  operation:
    schema:
      - key: "timeout"
        type: "integer"
        example: 45
        required: true
        description: |
          The maximum time (in seconds) of a single operation execution. This
          timeout should be as short as the longest possible execution of an
          operation.

resources:
  - parent: "Focus on SQL databases"
    title: "Focus on SQL databases"
    link: "/blacksmith/sqlstores"
    icon: "snowflake"

---

### Working with SQL databases

Once registered, an integration of type `sql` allows to interact with a SQL store 
for **L**oading data into a database. Within a trigger in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-sql-store"
            transformation:
              # ...
            options:
              # ...
```


It can also be leveraged for managing *migrations*, *operations*, and *selects*
like in this example:
```bash
$ blacksmith migrations run \
  --integration my-sql-store

1 migration to run for my-sql-store:
  - 20210809135841.init.up.sql

Blacksmith will run the migrations as shown above. Do you confirm?
Only 'yes' will be accepted to confirm.
> yes

Executing migrations:

  -> Executing 20210809135841.init.up.sql...
     Success!
```
