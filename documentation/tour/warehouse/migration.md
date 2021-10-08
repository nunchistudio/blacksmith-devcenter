---

resources:
  - parent: "Getting started"
    title: "Your first migration"
    link: "/blacksmith/start/discover/migration"
    icon: "magnifyWithPlus"
  - parent: "Focus on SQL databases"
    title: "How migrations work"
    link: "/blacksmith/sqlstores/migrations/how"
    icon: "timeline"
  - parent: "Focus on SQL databases"
    title: "Managing migrations"
    link: "/blacksmith/sqlstores/migrations/manage"
    icon: "timeline"

  - parent: "CLI reference"
    title: "CLI: migrations status"
    link: "/blacksmith/cli/migrations-status"
    icon: "console"
  - parent: "CLI reference"
    title: "CLI: migrations run"
    link: "/blacksmith/cli/migrations-run"
    icon: "console"
  - parent: "CLI reference"
    title: "CLI: migrations rollback"
    link: "/blacksmith/cli/migrations-rollback"
    icon: "console"

---

### SQL migrations

Migrations add a convenient way to evolve your databases' schemas over time.
Blacksmith has a unique set of migration features making the experience as smooth
as possible for software and data engineers.

Migrations are isolated by integration. Each SQL database registered as an
integration can have its own migrations. By doing so, you can leverage the native
dialect of each one.
