---

resources:
  - parent: "Focus on SQL databases"
    title: "Operations"
    link: "/blacksmith/sqlstores/transformations/operations"
    icon: "snowflake"
  - parent: "CLI reference"
    title: "CLI: run operation"
    link: "/blacksmith/cli/run-operation"
    icon: "console"

---

### SQL operations

An *operation* executes a query without returning any rows. When running an
operation, it is automatically wrapped inside a transaction to ensure it is either
entirely commited or rolled back if any error occured. Operations should be used
for managing / refreshing views (materialized or not).
