---
title: APM observability
enterprise: true
---

# APM observability

Blacksmith can integrate with [Elastic APM](https://www.elastic.co/apm/) for
monitoring and distributed tracing.

## Configuring Blacksmith

It uses the official [APM Go agent](https://www.elastic.co/guide/en/apm/agent/go/1.x/index.html)
and therefore can be configured by the [APM-reserved environment
variables](https://www.elastic.co/guide/en/apm/agent/go/1.x/configuration.html).

The only environment variable required is:
```bash
ELASTIC_APM_SERVER_URL=http://localhost:8200
```

If not set or empty, the APM Go agent will not be leveraged.

## APM Services & Traces

Blacksmith registers every instances of every services, as follow:
- `blacksmith-gateway`
- `blacksmith-server`
- `blacksmith-worker-loader`
- `blacksmith-worker-operator`

The environment variable `BLACKSMITH_ENV` is forwarded to APM, allowing to filter
services and instances across environments:

![Blacksmith APM on Elastic](/images/blacksmith/elastic-services.png)

Every workflows (for extractions, loads, migrations and operations) are traced.
This means you can monitor in details each workflow, per service per environment:

![Blacksmith APM on Elastic](/images/blacksmith/elastic-traces.png)
