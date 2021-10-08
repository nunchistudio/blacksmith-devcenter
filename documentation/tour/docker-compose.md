---

resources:
  - parent: "Getting started"
    title: "Creating an application"
    link: "/blacksmith/start/firstapp/create"
    icon: "bolt"

---

### Everything you need to get started

A `Docker-compose.yml` is generated along your application. This file is not
required for running the application but is here for convenience to help you get
started faster in development. It includes:
- A PostgreSQL database for the Blacksmith store (persistence).
- A PostgreSQL database for the Blacksmith visibility (search).
- A PostgreSQL database used as a simple warehouse across the guides.
- The Temporal UI for exploring your Blacksmith application.

You can customize the stack as much as you need, and then run it with:
```bash
$ docker compose up -d
```

It automatically initializes the Blacksmith `store` and `visibility` databases
when running for the first time so you don't need to worry about anything in a
development environment.
