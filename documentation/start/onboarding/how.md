---
title: How it works
enterprise: false
---

# How it works

Before jumping right into the installation and creating your first data engineering
platform, it's important to understand how Blacksmith works. In this document
you will discover concepts and internal mechanisms useful for both **software**
and **data** engineers.

Blacksmith allows **software engineers** to **E**xtract, **T**ransform (if desired),
and **L**oad data across services. This can be done using YAML / JSON configuration
only, or using our SDKs directly from third-party applications. It also allows
**data engineers** to run operations (a.k.a. **T**ransformations), queries (a.k.a.
*SELECT*s), and migrations on top of any SQL database.

This approach lets engineering teams collaborate on managing a unique data
engineering platform from end-to-end.

## Architecture

Blacksmith is built around some concepts, where the most important ones are as
followed:
- **Integrations** are systems you can interact with, such as databases or web
  services.
- The **server** is the orchestration service. The server itself does not execute
  application code, but instead tracks the state of it using queues, timers, and
  a database. It is highly scalable and multi-tenant, capable of running millions
  of tasks simultaneously. It employs various sharding techniques to ensure
  scalability internally. And it is capable of scaling horizontally by running
  multiple instances on multiple hosts.
- The **workers** are services that executes the code against integrations. There
  are two types of workers:
  - The **loader** is in charge of Loading data asynchronously into integrations.
    This worker is necessary if you leverage Blacksmith for ETL.
  - The **operator** is in charge of running operations, queries, and migrations
    synchronously against SQL integrations and leverages a remote *mutex* for
    handling access locks. This worker is necessary if you leverage Blacksmith
    for SQL operations and migrations.
- The **clients** give instructions to the server, such as Loading data or running
  migrations. There are three types of clients:
  - The **gateway** is a YAML / JSON-only application to Extract data from various
    sources and Load it into integrations. The gateway is very handy for capturing
    events across sources without knowing any programming language.
  - The **SDKs** can be used by software engineers inside existing applications.
    These applications only need to call a single function to Load data into
    integrations.
  - The **CLI** is used to run operations, queries, and migrations on top of SQL
    integrations.

In the following schema, we highlighted the E(T)L part:
![ETL with Blacksmith](/images/blacksmith/how-etl.png)

## Overview of SQL integrations

In addition to data **L**oading, SQL integrations are able to handle *selects*,
*operations*, and *migrations*.

A *select* executes a statement that returns rows, typically a `SELECT`. As the
name suggests, queries should be used for `SELECT`ing samples of data.

An *operation* executes a statement without returning any rows. When running an
operation, it is automatically wrapped inside a transaction to ensure it is either
entirely commited or rolled back if any error occured. Operations should be used
for managing / refreshing views (materialized or not).

An operation should never be used for evolving the database schema such as tables
and colums, which could impact software engineers. In this scenario, you should
take advantage of *migrations*. Migrations add a convenient way to evolve your
databases' schemas over time.

As an example, the following command is executed from the CLI — a client. It
connects to a Blacksmith server, which delegates the task to the worker `operator`,
and finally returns the status of the migrations for the integration named
`warehouse`:
```bash
$ blacksmith migrations status \
  -i warehouse

Latest migration:
  20210514110000.add_fields.up.sql (applied)

1 migration to run for warehouse:
  - 20210514123223.fix_email_pkey.up.sql (new)
```

In the following schema, we highlighted the SQL database-focused part for
*operations* and *migrations*:
![SQL with Blacksmith](/images/blacksmith/how-sqlstores.png)

As you can notice, *selects* don't rely on the server / workers architecture.
Selects are executed directly against the database. It is designed this way because,
unlike operations and migrations, selects can't modify a database's schema.
Therefore, it's unnecessary to block the task queue by acquiring a lock in the
*mutex*. Also, there can be millions or billions or rows returned, exceeding the
size limit of messages between services.

## Temporal workflows

Blacksmith is built on top of [Temporal](https://temporal.io/), an open source
runtime for running highly reliable, scalable microservice orchestration for
mission-critical applications.

Whether it is an event happening from a data **E**xtraction, a migration, or an
operation triggered from the CLI, it creates a *workflow* in the underlying Temporal
server. Each workflow is attached to a namespace as well as an integration you
registered in your Blacksmith application, such as `warehouse`.

**That's it. You don't need to dive more into Temporal for working with
Blacksmith.**

Each workflow has a unique workflow ID:
- Each workflow for an event is related to a UUID, such as
  `0baccef4-2feb-4e29-8cce-b276a0726000`.
- Each workflow for an SQL operation is related to its filename, such as
  `refresh-view-stats.sql`.
- Each workflow for a SQL migration is related to its filename without the `up`
  or `down` direction, such as `20210514110000.add_fields.sql`.

## Overview of namespaces

Blacksmith has support for namespaces, which allow every workflows to be segmented
from each other and other users of the cluster. Blacksmith places *everything*
into namespaces.

Namespaces are useful for isolation. The main use case is isolation *by tenant*
(multi-tenancy) when you wish to have dedicated resources and policies for each
team or customer.

Clients and workers are always related to a namespace. Whereas the server is
common for all namespaces of an organization, a worker is dedicated to a single
namespace. Therefore, if you want to leverage both the loader and operator workers
for 3 namespaces, you must have 6 running workers (or more for high availability).

Blacksmith **Standard Edition** offers the possibility to have a single namespace
called `default`. However, the **Enterprise Edition** allows organizations to
manage multiple namespaces, where each one can have an owner and specific
settings such as a custom retention period.

Knowing this, we can now highlight the components specific to a single namespace,
that therefore are completely isolated from one namespace to another:
![Namespaces in Blacksmith](/images/blacksmith/how-namespaces.png)

We provide [more resources about namespaces](/blacksmith/enterprise/namespaces/how)
in the guides focusing on Blacksmith Enterprise Edition.

## Handling configuration

Blacksmith is configured via YAML or JSON files, located in a directory. In the
example below, the application uses YAML in the `blacksmith` directory.

Blacksmith handles sensitive information and environment-specific configuration
via environment variables. To simplify this approach, Blacksmith automatically
load these variables from `.env` files, if any. It first loads the ones from the
`.env` file. Then the ones from `.env.development` where `development` is the value
of the variable `BLACKSMITH_ENV`. Order matters since no environment variables
are overridden.

A `.env` shall look like this:
```bash
# The relative path to find configuration files.
BLACKSMITH_DIR=blacksmith

# The environment to load configuration for. This allows to
# apply the environment variables found in `.env.development`.
BLACKSMITH_ENV=development

# The config file extension to use. Configuration can be
# YAML (`yml`) or JSON (`json`).
BLACKSMITH_EXT=yml

# The Blacksmith namespace to connect to. This may vary between
# environments if you leverage namespaces for environment isolation.
BLACKSMITH_NAMESPACE=default
```

While the `.env` shall contain variables applicable to all environments, the one
sufixed by an environment's name shall only contain the variables applicable to
the current environment. A `.env.development` shall look like this:
```bash
# The Blacksmith server URL to connect to. This shall vary between
# environments.
BLACKSMITH_SERVER_URL=localhost:7200
```

In the documentation, all configuration files are written in YAML. We assume the
config directory (`BLACKSMITH_DIR`) is `blacksmith`.
