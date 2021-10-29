---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-webhook"
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

### Working with topics

Once registered, an integration of type `webhook` allows to interact with a HTTP
API for **L**oading data into a web service. Within a trigger in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-webhook"
            transformation:
              # ...
            options:
              # ...
```
