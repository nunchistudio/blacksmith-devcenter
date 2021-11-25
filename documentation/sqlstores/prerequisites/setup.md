---
title: Registering a SQL integration
enterprise: false
---

# Registering a SQL integration

Like any other integration, a SQL one must be registered in the file dedicated
to integrations. If `BLACKSMITH_EXT` is `yml`, a SQL integration shall be
configured as follow in `BLACKSMITH_DIR/integrations.yml`:
```yml
sql:
  - name: "warehouse"
    driver: "postgresql"
    connection: "WAREHOUSE_URL"
    policies:
      migration:
        path: "./warehouse/migrations"
        timeout: 45
      operation:
        timeout: 45
      load:
        timeout: 15
        initialInterval: 30
        backoffCoefficient: 1.75
        maximumInterval: 3600
        maximumAttempts: 50
```

This integration is named `warehouse`. This is the name that must be set when
an integration's name is required.

Refer to the [interactive tour](/blacksmith/tour) for all options and drivers.
