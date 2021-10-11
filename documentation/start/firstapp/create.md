---
title: Creating an application
enterprise: false
---

# Creating an application

## Generate the application

The best way to create a new Blacksmith application is by using the `generate`
command of the CLI. The following command generates all the required files in the
current directory:
```bash
$ blacksmith generate application \
  --name myapp
```

If you prefer, you can generate a new application inside a directory with the
`--path` flag:
```bash
$ blacksmith generate application \
  --name myapp \
  --path ./myapp
```

The directory will be created if it does not exist yet.

This command generates hidden files starting with a dot, such as `.env` files
for managing environment variables. You may need to update your code editor or
system preferences to access and edit those files. Take a look at the [application
reference](/blacksmith/tour) to discover what they look like.

## Docker stack for development

A `Docker-compose.yml` is generated along your application. This file is not
required for running the application but is here for convenience to help you get
started faster in development. It includes:
- A PostgreSQL database for the Blacksmith store (persistence).
- A PostgreSQL database for the Blacksmith visibility (search).
- A PostgreSQL database used as a simple warehouse across the guides.
- The Temporal UI for exploring your Blacksmith application.

It automatically initializes the Blacksmith `store` and `visibility` databases
when running for the first time so you don't need to worry about anything in a
development environment. This automation uses Docker's file sharing. Therefore,
you must  ensure the directory where the application has been generated can be
bind mounted into Docker containers:

![Docker file sharing](/images/blacksmith/docker-sharing.png)

If not properly initialized, the `store` and `visibility` databases will not have
the required schemas. Blacksmith will then return a SQL error when starting the
server.

You can customize the stack as much as you need and run it with:
```bash
$ docker compose up -d
```
