---
title: Focus on SQL databases
enterprise: false
---

# Focus on SQL databases

As detailed in the "[Getting started](/blacksmith/start/onboarding/how)",
Blacksmith offers features specifically designed for SQL databases.

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

In the following guides, we focus on the highlighted part of the schema:
![SQL with Blacksmith](/images/blacksmith/how-sqlstores.png)
