---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-http-api"
      required: true
      description: |
        The name of the integration to register.

    - key: "base_url"
      type: "string"
      example: "http://example.com"
      required: true
      description: |
        HTTP base URL without the trailing slash that will prefix all the
        HTTP endpoints registered in this integration.

---

### Working with HTTP APIs

Once registered, an integration of type `http` allows to interact with a web
service for **L**oading via a HTTP API. Within a trigger in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-http-api"
            transformation:
              # ...
            config:
              # ...
```
