---

resources:
  - parent: "Getting started"
    title: "How Blacksmith works"
    link: "/blacksmith/start/onboarding/how"
    icon: "cheer"
  - parent: "Getting started"
    title: "Setting up the gateway"
    link: "/blacksmith/start/discover/gateway"
    icon: "magnifyWithPlus"
  - parent: "Getting started"
    title: "Your first event"
    link: "/blacksmith/start/discover/event"
    icon: "magnifyWithPlus"

  - parent: "CLI reference"
    title: "CLI: start gateway"
    link: "/blacksmith/cli/start-gateway"
    icon: "console"
  
---

### About the gateway

The Blacksmith **gateway** is a YAML / JSON-only application to **E**xtract data
from various sources, **T**ransform (if desired) and **L**oad it into integrations.
The gateway allows to have an end-to-end ETL pipeline without knowing any
programming language and without worrying about data reliabilty: Blacksmith handles
orchestration under the hood thanks to its server / worker architecture.
