---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-nosql-store"
      required: true
      description: |
        The name of the integration to register.

    - key: "driver"
      type: "string"
      required: true
      description: |
        The driver to leverage for puting a document.
    
    - key: "connection"
      type: "string"
      required: true
      description: |
        The driver-specific connection string.

    - key: "params"
      type: "url.Values"
      description: |
        Driver-specific params to pass to the connection string.

---

### Working with NoSQL databases

Once registered, an integration of type `nosql` allows to interact with a NoSQL
store for **L**oading data into a collection. Within a trigger in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-nosql-store"
            transformation:
              # ...
            config:
              # ...
```
