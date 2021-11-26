---
title: First steps with the gateway
enterprise: false
---

# First steps with the gateway

There are two ways for **L**oading data into an integration. Either way, it is
done by using a client. You can either **E**xtract, **T**ransform, and **L**oad
using YAML / JSON only by leveraging the gateway. Or you can Load data directly
from applications using our SDKs.

We strongly advise to open the [Application reference](/blacksmith/tour) and play
within the `gateway` directory to discover more in depth the behavior for each
sources' and integrations' behavior.

## Configuring the gateway

For these guides, we will configure and run the gateway. The gateway needs to be
configured in `BLACKSMITH_DIR/services.BLACKSMITH_EXT`. The only required
configuration is the HTTP address to listen on:
```yml
gateway:
  address: ":9090"
```

## Sources and triggers

Every files in the directory `BLACKSMITH_DIR/gateway/*.BLACKSMITH_EXT` can register
*sources* and *triggers*. Configuration present in these files is merged when
starting the workers. Since all those files are merged together to build the
gateway, we advise to have one file for one source and all its triggers.

A *source* is a collection of *triggers* **E**xtracting events' data from a same
source. A source can register triggers of different modes, where the mode is one
of:
- `http_endpoint` registers a HTTP route within the HTTP server of the gateway.
  It is useful for capturing events from external webhooks. The **E**xtracted
  data is the payload sent by the HTTP request.
- `http_client` makes a HTTP request against an external web service based on a
  CRON schedule. The **E**xtracted data is the HTTP response returned by the API.
- `cdc` is a Change Data Capture for databases. It listens to changes within a
  database and streams the changes into the trigger. The **E**xtracted
  data contains some details such as the `table`, `operation`, `old` row, and
  `new` row. We support different drivers:
  - MongoDB (`mongodb`)
  - PostgreSQL (`postgresql`)
- `subscription` subscribes to a *topic* of a message broker. The **E**xtracted
  data is the message received by the subscription. We support different drivers:
  - Apache Kafka (`kafka`)
  - AWS SQS (`aws/sqs`)
  - Azure Service Bus (`azure/servicebus`)
  - Google Pub / Sub (`google/pubsub`)
  - NATS (`nats`)
  - RabbitMQ (`rabbitmq`)

## Your first trigger

First, let's register a source named `api` in a file named `api.yml` inside the
directory dedicated to the gateway:
```yml
sources:
  - name: "api"
    defaults:
      http_endpoint:
        prefix: "/api"
        policies:
          extraction:
            timeout: 5
```

Sources can have `defaults` configuration which will be applied to all triggers
of the given mode. In the example above, every routes of this source only will
be prefixed by `/api`.

Let's register a trigger inside the `triggers` of the source, using the mode
`http_endpoint`:
```yml
sources:
  - name: "api"
    defaults:
      http_endpoint:
        prefix: "/api"
        policies:
          extraction:
            timeout: 5
    triggers:
      - name: "new_user"
        mode: "http_endpoint"
        config:
          http_endpoint:
            method: "POST"
            endpoint: "/users"
```

The gateway now exposes a route `POST` on `/api/users`.

## Transform & Load

We now can add the integration `warehouse` in the `integrations` object. The
integrations can take a `transformation` and `config`, specific to each kind of
integration. In `transformation` and `config` the value for each key can leverage
the [Transformation syntax](/blacksmith/transformation).

Since we are working with a SQL integration, only the `config.query` shall be set:
```yml
sources:
  - name: "api"
    defaults:
      http_endpoint:
        prefix: "/api"
        policies:
          extraction:
            timeout: 5
    triggers:
      - name: "new_user"
        mode: "http_endpoint"
        config:
          http_endpoint:
            method: "POST"
            endpoint: "/user"
        integrations:
          - name: "warehouse"
            config:
              query: |
                INSERT INTO users (id, username) VALUES
                  ('{% uuid %}', '{% query "body.user.username" %}');
```

If we were to work with a non-SQL integration, the `transformation` must be set.
It represents the *body* that will be **L**oaded to the integration. In the
following example, data will be **L**oaded both in the `nonexisting-nosql` and
in the `warehouse` integrations:
```yml
sources:
  - name: "api"
    # ...
    triggers:
      - name: "new_user"
        # ...
        integrations:
          - name: "nonexisting-nosql"
            transformation:
              id: "{% uuid %}"
              username: "{% query 'body.user.username' %}"
            config:
              # ...
          - name: "warehouse"
            config:
              query: |
                INSERT INTO users (id, username) VALUES
                  ('{% uuid %}', '{% query "body.user.username" %}');
```

If the value `body.user.username` is `johndoe`, the JSON put in the non-SQL
integration named `nonexisting-nosql` would be:
```json
{
  "id": "ec29b038-80d6-4063-b72b-9606c676f01d",
  "username": "johndoe"
}
```

Whereas the SQL query executed against the `warehouse` would be:
```sql
INSERT INTO users (id, username) VALUES
  ('ec29b038-80d6-4063-b72b-9606c676f01d', 'johndoe');
```

Note that every SQL queries in **L**oads, migrations, and operations are wrapped
automatically inside a transaction ensuring atomicity: either fully succeeded or
failed.

Depending on the integration's kind, some `config` may be applicable: for
validating the encoding or content language, defining metadata, etc.

In summary, this trigger accepts `POST` requests on `/api/user`. On each request,
data is **T**ransformed and **L**oaded for the integration `warehouse` using the
SQL query in `query`. In `transformation` and `config` the value for each key can
leverage the [Transformation syntax](/blacksmith/transformation). This way, the
query here is compiled, then executed against the integration.

You now need to restart the worker `loader`, as well as start the gateway:
```bash
$ blacksmith start gateway
```

The gateway is ready to accept events on this new HTTP route. However our database
is not. Let's create our first migration!
