---
title: Setting up the gateway
enterprise: false
---

# Setting up the gateway

There are two ways for **L**oading data into an integration. Either way, it is
done by using a client. You can either **E**xtract, **T**ransform, and **L**oad
using YAML / JSON only by leveraging the gateway. Or you can Load data directly
from applications using our SDKs.

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
starting the workers.

A *source* is a collection of *triggers* Extracting events' data from a same
source. A source can register triggers of different modes, where the mode is one
of:
- `http_endpoint` registers a HTTP route within the HTTP server of the gateway.
  It is useful for capturing events from external webhooks. The **E**xtracted
  data is the payload sent by the HTTP request.
- `http_client` makes a HTTP request against an external web service based on a
  CRON schedule. The **E**xtracted data is the HTTP response returned by the API.
- `sql_cdc` is a Change Data Capture for SQL databases. It listens to changes
  within a database and streams the changes into the trigger. The **E**xtracted
  data contains some details such as the `table`, `operation`, `old` row, and
  `new` row. We support different drivers:
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
```

The sources can have `defaults` configuration which will be applied to all triggers
of the given mode. In the example above, every routes of this source only will
be prefixed by `/api`.

Now, we register a trigger inside the `triggers` of the source, using the mode
`http_endpoint`:
```yml
sources:
  - name: "api"
    defaults:
      http_endpoint:
        prefix: "/api"
    triggers:
      - name: "new_user"
        mode: "http_endpoint"
        config:
          http_endpoint:
            method: "POST"
            endpoint: "/users"
```

The gateway now exposes a route `POST` on `/api/users`.

Finally, we add the integration `warehouse` in the `integrations` object.
The integration takes a `mapping` in addition to `options`, specific to each
kind of integration:
```yml
sources:
  - name: "api"
    defaults:
      http_endpoint:
        prefix: "/api"
    triggers:
      - name: "new_user"
        mode: "http_endpoint"
        config:
          http_endpoint:
            method: "POST"
            endpoint: "/users"
        integrations:
          - name: "warehouse"
            mapping:
              user: "body.user"
            options:
              inline: |
                INSERT INTO users (id, username) VALUES
                  ('{% uuid %}', '{{ user.username }}');
```

The `mapping` allows to expose data to the integrations, mapped from keys exposed
by the trigger. In the example above, the integration `warehouse` has access to
a key `user`, which is the data of `body.user` exposed by the trigger. Knowing
this, the integration can insert a new user by accessing the `user` object exposed
by the `mapping`.

In summary, this triggers accepts `POST` requests on `/api/users`. On each request,
the integration `warehouse` is leveraged and the query in `inline` is executed.

The gateway is ready to accept events on this new HTTP route. However our database
is not. Let's create our first migration!
