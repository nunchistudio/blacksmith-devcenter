# Blacksmith developer center

Blacksmith allows **software engineers** to **E**xtract, **T**ransform (if desired),
and **L**oad data across services. This can be done using YAML / JSON configuration
only, or using our SDKs directly from third-party applications. It also allows
**data engineers** to run operations (a.k.a. **T**ransformations), queries (a.k.a.
*SELECT*s), and migrations on top of any SQL database.

This approach lets engineering teams collaborate on managing a unique data
engineering platform from end-to-end.

Any team that is building — or think about building — such a platform knows the
tremendous amount of work needed to properly accomplish this mission. Think of
Blacksmith as the central piece of your data engineering workflow, leading you to
save months of customized and professional work.

## Features and benefits

### Invincible ETL / ELT

Blacksmith architecture is designed to:
- **Survive anything**: Blacksmith provides hard guarantees around the durability
  of data and seamlessly deals with long-running operations, retries, and
  intermittent failures.
- **Scale easily**: Scalability is another crucial advantage of using Blacksmith
  for data processing. It automatically distributes data and workload demand
  across workers.
- **Deploy everywhere**: Blacksmith works on any machine and any cloud to respect
  organizational, technical, and legal requirements your organization or customers
  might have.

[The Blacksmith recipes](https://nunchi.studio/blacksmith/recipes) allow you to
configure your integrations along ETL / ELT within a few lines:

```yml
sources:
  - name: "my-source"
    defaults:
      subscription:
        driver: "kafka"
    triggers:
      - name: "my-trigger"
        mode: "subscription"
        config:
          subscription:
            topic: "<topic>"
            queue: "<consumer-group>"
```

### Database operations

Blacksmith exposes a Python / Django-syntax like templating-language when working
with SQL files. This is a convenient way to generate SQL dynamically interpolating
the template with contextual data and returning the compiled SQL file.

```sql
{% if order %}
INSERT INTO orders (id, amount, user_id, created_at)
  VALUES (
    '{% uuid %}',
    {{ order.amount | floatformat:2 }},
    '{{ user.id }}',

    {% if order.created_at %}
      '{{ order.created_at }}'
    {% else %}
      '{% now "2006-01-02 15:04:05" %}'
    {% endif %}
  );
{% endif %}
```

Load & Transform data within multiple SQL databases leveraging the native dialect
of each one:

![SQL within ELT with Blacksmith](https://nunchi.studio/gifs/blacksmith/cli-run-operation.gif)

Run `SELECT` in your database and download the returned rows as CSV and JSON:

![SQL within ELT with Blacksmith](https://nunchi.studio/gifs/blacksmith/cli-run-select.gif)

### Database migrations

Version, run, rollback, and discard migrations for an integration:

![Rolling back migrations](https://nunchi.studio/gifs/blacksmith/cli-migrations-rollback.gif)

Check the status of migrations for an integration:

![Checking migrations status](https://nunchi.studio/gifs/blacksmith/cli-migrations-status.gif)

## Product offerings

**Blacksmith is not an open-source software.** This repository only holds useful
developer resources. Blacksmith itself is built and distributed as a CLI and as
a Docker image.

[Blacksmith is available in two Editions](https://nunchi.studio/blacksmith/pricing):
- **Blacksmith Standard Edition** is aimed at individuals and small teams. It
  addresses the technical challenges they face when building cloud-native and
  reliable data engineering solutions.
- **Blacksmith Enterprise Edition** is aimed at larger teams. It addresses the
  governance and collaboration challenges they face when working on more complex
  data solutions. It brings additional features such as *namespaces* (for
  multi-tenancy) and a deep integration with the Elastic Stack.

![Blacksmith with Elastic](https://nunchi.studio/images/blacksmith/elastic-traces.png)

## Professional services

Along consulting and training, we provide different product offerings as well as
different levels of support.

- [Request a demo](https://nunchi.studio/blacksmith/forms/demo)
- [Discover our services](https://nunchi.studio/support)

## License

Repository licensed under the [Apache License, Version 2.0](./LICENSE).

By downloading, installing, and using Blacksmith, you agree to the
[Blacksmith Terms and Conditions](https://nunchi.studio/legal/terms).
