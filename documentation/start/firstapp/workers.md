---
title: Running the workers
enterprise: false
---

# Running the workers

The workers must be running if you want clients to interact with integrations.
They are the middlemen executing the desired tasks. As detailed in the ["How it
works"](/blacksmith/start/onboarding/how), the `loader` and `operator` are two
workers running different kind of tasks:
- The **loader** is in charge of Loading data asynchronously into integrations.
  This worker is necessary if you leverage Blacksmith for ETL.
- The **operator** is in charge of running operations, queries, and migrations
  synchronously against SQL integrations and leverages a remote *mutex* for
  handling access locks. This worker is necessary if you leverage Blacksmith for
  SQL operations and migrations.

## Environment

In addition to `BLACKSMITH_DIR`, `BLACKSMITH_ENV`, and `BLACKSMITH_EXT`, workers
rely the following environment variables to properly work:
```bash
BLACKSMITH_SERVER_URL=localhost:7200
BLACKSMITH_NAMESPACE=default
```

## The default namespace

Before starting the workers, let's create the `default` namespace with a retention
period of 14 days:
```bash
$ blacksmith namespaces create \
  --name default \
  --retention 336h

Managing namespaces:

  -> Creating namespace default...
     Success!
```

Note that the retention passed is a duration in minutes or hours. Working with
days can be confusing for several reasons [as explained in the guides dedicated
to namespaces](/blacksmith/enterprise/namespaces/how).

The namespace `default` is now registered in the server. The workers that will be
started next will be dedicated to this namespace only.

## Starting the workers

The worker `loader` execute the tasks for **L**oading data into integrations. You
can start this worker with:
```bash
$ blacksmith start worker loader
```

The worker `operator` execute the tasks for running queries against SQL databases
such as operations and migrations. You can start this worker with:
```bash
$ blacksmith start worker operator
```

Now that the server and workers are up and running, let's dive into some details
to help you discover Blacksmith step-by-step.
