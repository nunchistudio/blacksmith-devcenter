---

dotenv:
  schema:
    - key: "BLACKSMITH_DIR"
      type: "string"
      example: "blacksmith"
      defaults: "blacksmith"
      description: |
        The relative path to find the Blacksmith configuration files.

    - key: "BLACKSMITH_ENV"
      type: "string"
      example: "development"
      defaults: "development"
      description: |
        The environment to load configuration for. This allows  to apply
        the environment variables found in `.env.development`.

    - key: "BLACKSMITH_EXT"
      type: "string"
      example: "yml"
      defaults: "yml"
      description: |
        The config file extension to use. It must be one of `yml`, `json`.

resources:
  - parent: "Getting started"
    title: "How Blacksmith works"
    link: "/blacksmith/start/onboarding/how"
    icon: "cheer"
  - parent: "Focus on Enterprise Edition"
    title: "Handling multi-tenancy"
    link: "/blacksmith/enterprise/namespaces/tenancy"
    icon: "indexSettings"
  - parent: "CLI reference"
    title: "CLI: env"
    link: "/blacksmith/cli/env"
    icon: "console"

---

### Environment variables

Blacksmith uses environment variables for environment-specific configuration and
for sensitive information — such as connection strings.

To simplify this approach, Blacksmith automatically load these variables from
`.env` files, if any. It first loads the ones from the `.env` file. Then the ones
from `.env.development` where `development` is the value of the variable
`BLACKSMITH_ENV`. Order matters since no environment variables are overridden.

The variables present in this file should always be the same across repositories
when working in a multi-repositories setup. Otherwise, you will end up with
different repository structures leading to confusion and misconfiguration. 
