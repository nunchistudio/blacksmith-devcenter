---

dotenvdotenv:
  values:
    ANY_ENV_VAR: "postgres://<user>:<password>@<host>:<port>"

gateway:
  trigger:
    values:
      channel: "users"

---

In order to listen events from a PostgreSQL database, you first need to run the
following code. It creates a new function notifying clients on row changes.

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE OR REPLACE FUNCTION notify_event()
  RETURNS TRIGGER AS $$
    DECLARE 
      old_row JSON;
      new_row JSON;
      notification JSON;

    BEGIN
      old_row = row_to_json(OLD);
      new_row = row_to_json(NEW);

      notification = json_build_object(
        'id', uuid_generate_v4(),
        'table', TG_TABLE_NAME,
        'action', TG_OP,
        'old', old_row,
        'new', new_row
      );

      PERFORM pg_notify(TG_ARGV[0], notification::text);
      RETURN NULL; 
    END;

$$ LANGUAGE plpgsql;
```

Now, you are able to create a trigger that will execute this function. Here, the
trigger will stream changes of the table `users` on `INSERT`, `UPDATE`, and
`DELETE`. The *channel* name that will be used is `users`.
```sql
CREATE TRIGGER users_notify_event
  AFTER INSERT OR UPDATE OR DELETE ON users
  FOR EACH ROW EXECUTE PROCEDURE notify_event('users');
```
