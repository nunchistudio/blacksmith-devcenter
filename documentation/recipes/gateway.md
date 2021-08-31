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
      required: true
      description: |
        The Blacksmith server URL to connect to shall vary between
        environments.

services:
  gateway:
    schema:
      - key: "address"
        type: "string"
        example: ":1337"
        defaults: ":1337"
        required: true
        description: |
          The address and port to which the service gateway is listening to.

      - key: "cors"
        type: "object"
        items:
          - key: "allowedOrigins"
            type: "[]string"
            description: |
              List of origins a cross-domain request can be executed from. If the
              special `*` value is present in the list, all origins will be allowed.
              An origin may contain a wildcard (`*`) to replace 0 or more characters.
              Only one wildcard can be used per origin.
          - key: "allowedMethods"
            type: "[]string"
            description: |
              A list of methods the clients are allowed to use with cross-domain
              requests.
          - key: "allowedHeaders"
            type: "[]string"
            description: |
              A list of non simple headers the client is allowed to use with
              cross-domain requests.
          - key: "allowCredentials"
            type: "boolean"
            description: |
              Indicates whether the request can include user credentials like
              cookies, HTTP authentication or client side SSL certificates.
          - key: "exposedHeaders"
            type: "[]string"
            description: |
              Indicates which headers are safe to expose to the API of a CORS API
              specification.
          - key: "maxAge"
            type: "integer"
            description: |
              Indicates how long (in seconds) the results of a preflight request
              can be cached. `0` which stands for no max age.
        example:
          allowedOrigins: ["http://*.domain.com"]
          allowedMethods: ["POST", "PUT"]
          allowedHeaders: []
          allowCredentials: true
          exposedHeaders: []
          maxAge: 0
        defaults:
          allowedOrigins: ["*"]
          allowedMethods: ["GET", "POST"]
          allowedHeaders: []
          allowCredentials: false
          exposedHeaders: []
          maxAge: 0
        description: |
          Optional configuration for applying Cross Origin Resource Sharing to the
          gateway.

---

The gateway allows to **E**xtract data from various systems with configuration
files only. It acts as a *middleman* between third-party services and integrations
to first **E**xtract the data from sources, then **L**oad the desired data to
integrations.
