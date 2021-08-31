---
title: blacksmith
enterprise: false
---

# `blacksmith`

The Blacksmith CLI allows developers and operators to manage and run a Blacksmith
application.

**Example:**
```bash
$ blacksmith --help

NAME:
   blacksmith - Blacksmith CLI

USAGE:
   blacksmith [global options] command [command options] [arguments...]

COMMANDS:
   env         Outputs the current Blacksmith environment
   generate    Generates Blacksmith files
   migrations  Manages migrations across integrations
   namespaces  Manages multi-tenancy with namespaces
   run         Runs operations and queries across integrations
   start       Starts a server, worker, or gateway
   version     Outputs the current Blacksmith version
   login       Logs into the Nunchi Customer Portal
   help, h     Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h  show help (default: false)
```

## Global optional flags

The following flags are shared across every commands.

- `--help`: Prevents the command to be executed and display the help of the said
  command instead.

  **Example:**
  ```bash
  $ blacksmith migrations status --help
  ```
