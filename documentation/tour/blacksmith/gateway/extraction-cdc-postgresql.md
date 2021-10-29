---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      example: "postgres://<user>:<password>@<host>:<port>"
      required: true
      description: |
        The PostgreSQL connection string to connect to for streaming events to
        Change Data Capture triggers.

gateway:
  trigger:
    values:
      stream: "users"
      params:
        tables:
          - "public.accounts"
          - "public.users"
        operations:
          - "insert"
          - "update"
          - "delete"

---

### Configuring PostgreSQL

In order to listen events from a PostgreSQL database, you first need to run the
following code. It creates a new function notifying clients on row changes with
the appropriate values for the `id`, `target`, `operation`, and `body` keys
required by the gateway.

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE OR REPLACE FUNCTION notify_event()
  RETURNS TRIGGER AS $$
    DECLARE
    	body JSON;
      notification JSON;

    BEGIN
      body = row_to_json(NEW);
      IF TG_OP = 'DELETE' THEN
        body = row_to_json(OLD);
      END IF;

      notification = json_build_object(
        'id', uuid_generate_v4(),
        'target', concat_ws('.', TG_TABLE_SCHEMA, TG_TABLE_NAME),
        'operation', TG_OP,
        'body', body
      );

      PERFORM pg_notify(TG_ARGV[0], notification::text);
      RETURN NULL; 
    END;

$$ LANGUAGE plpgsql;
```

Now, you are able to create a trigger that will execute this function. Here, the
trigger will stream changes of the table `users` on `INSERT`, `UPDATE`, and
`DELETE`. The *stream* name is the one passed in `notify_event()`. In this case
it is `users`.
```sql
CREATE TRIGGER users_notify_event
  AFTER INSERT OR UPDATE OR DELETE ON users
  FOR EACH ROW EXECUTE PROCEDURE notify_event('users');
```

Since other applications may want to receive changes using the same trigger you
just defined, Blacksmith allows to filter these events at the **E**xtraction step
as well. For example, the `users_notify_event` defined above is triggered on
`INSERT`, `UPDATE`, and `DELETE`. If you only want to **E**xtract data in Blacksmith
to an integration only on `DELETE`, you can add `params` with desired `tables`
and `operations`.

On `INSERT` and `UPDATE` operations, the `body` returned is the new row that has
just been inserted or updated.

On `DELETE` operations, the `body` returned is the old row that is now deleted.
It is designed this way allowing you to **E**xtract some information that could
be useful for **T**ransformation and **L**oad.

An **E**xtraction result can be represented as:
```json
{
  "status": "success",
  "id": "b7164e75-5ab1-496b-9277-9040746a5efc",
  "target": "public.users",
  "operation": "INSERT",
  "body": {
    "<column>": "<value>"
  }
}
```

If no `params.tables` are set, all events from all tables triggered by the
`TRIGGER` will be **E**xtracted.

If no `params.operations` are set, all operations `INSERT`, `UPDATE`, and `DELETE`
will be **E**xtracted.
