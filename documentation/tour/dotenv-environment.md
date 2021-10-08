---

dotenvdotenv:
  schema:
    - key: "BLACKSMITH_NAMESPACE"
      type: "string"
      example: "default"
      defaults: "default"
      description: |
        The Blacksmith namespace to connect to.

    - key: "BLACKSMITH_SERVER_URL"
      type: "string"
      example: "localhost:7200"
      defaults: "localhost:7200"
      description: |
        The Blacksmith server URL to connect to shall vary between
        environments.

    - key: "BLACKSMITH_STORE_URL"
      type: "string"
      example: "postgres://<user>:<password>@<host>:<port>"
      defaults: "postgres://<user>:<password>@<host>:<port>"
      required: true
      description: |
        The PostgreSQL URL for the Blacksmith store database.

    - key: "BLACKSMITH_VISIBILITY_URL"
      type: "string"
      example: "postgres://<user>:<password>@<host>:<port>"
      defaults: "postgres://<user>:<password>@<host>:<port>"
      required: true
      description: |
        The PostgreSQL URL for the Blacksmith visibility database.

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

### Environment-specific variables

While the `.env` shall contain variables applicable to all environments, the one
sufixed by an environment's name shall only contain the variables applicable to
the current environment.

Note that the database URLs are not outputted for security reasons. Depending on
your environment, the history might be logged / registered.
