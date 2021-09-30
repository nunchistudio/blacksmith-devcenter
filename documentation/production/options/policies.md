---
title: Appropriate policies
enterprise: false
---

# Appropriate policies

Policies are a really important feature of Blacksmith. They have the effect of
adding a reliability layer atop an integration, in a durable and scalable way.
Misconfigured policies can lead to an unreliable integration.

A complete `policies` configuration for an integration shall look like this:
```yml
integrations:
  sql:
    - name: "my-sql-store"
      driver: "postgresql"
      policies:
        operation:
          timeout: 45
        migration:
          timeout: 45
        load:
          timeout: 15
          initialInterval: 30
          backoffCoefficient: 1.75
          maximumInterval: 15
          maximumAttempts: 60
```

**Note:** The `operation` and `migration` policies are only available for `sql`
integrations.

`operation` policies:
- `timeout` (in seconds) is the maximum time of a single database operation's
  execution attempt. This timeout should be as short as the longest possible
  execution of the operation.

`migration` policies:
- `timeout` (in seconds) is the maximum time of a single database migration's
  execution attempt. This timeout should be as short as the longest possible
  execution of the migration.

`load` policies:
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
