---
title: Your first integration
enterprise: false
---

# Your first integration

The server and workers are up and running, but are useless without integrations.

## Registering the integration

Integrations are registered in the file dedicated located at
`BLACKSMITH_DIR/integrations.BLACKSMITH_EXT`. For the purpose of these guides,
we'll register a SQL integration using the PostgreSQL driver. It is the container
[in the Docker stack previously started](/blacksmith/start/firstapp/create).

Every integrations are registered under the `integrations` key, mapped by their
integration kind. `sql` allows to register multiple SQL integrations. Everyone
one of them must have a unique name.

The minimal configuration for a SQL integration is as follow:
```yml
integrations:
  sql:
    - name: "warehouse"
      driver: "postgresql"
      connection: "ANY_ENV_VAR"
```

The connection string to connect to the SQL store is retrieved from an environment
variable. Here, the connection string of the integration `warehouse` is the value
of the environment variable `ANY_ENV_VAR`:
```bash
ANY_ENV_VAR=postgres://<user>:<password>@<host>:<port>/<db>?<params>
```

## Adding policies

In addition to a required `name` and integration-specific configuration, an
integration can have `policies`:
```yml
integrations:
  sql:
    - name: "warehouse"
      driver: "postgresql"
      connection: "ANY_ENV_VAR"
      policies:
        load:
          timeout: 20
          initialInterval: 30
          backoffCoefficient: 2
          maximumInterval: 3600
          maximumAttempts: 50
```

The `load` policies are applied when **L**oading data into the integration. They
are as follow:
- `timeout` (in seconds) is the maximum time of a single data **L**oad execution
	attempt. This timeout should be as short as the longest possible execution
	of the **L**oad.
- `initialInterval` (in seconds) is the backoff interval for the first retry.
- `backoffCoefficient` is the coefficient used to calculate the next retry
	backoff interval. The next retry interval is previous interval multiplied
	by this coefficient. Must be `1.0` or larger.
- `maximumInterval` (in seconds) is the maximum backoff interval between retries.
  Exponential backoff leads to interval increase. This value is the cap of the
  interval. If not interval is provided, the value is `100 * initialInterval`.
- `maximumAttempts` is the maximum number of attempts of retries. When exceeded
  the retries stop even if not expired yet.

## Re-starting the workers

Now that the integration is registered, we can re-start the workers so they are
aware of the changes we've just made.

Note that we do not need to restart the server! This way, the server is always
up to avoid connections loses with the clients as much as possible.

We now have a ready-to-use integration. How can we Load data into it?
