---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-bucket"
      required: true
      description: |
        The name of the integration to register.

    - key: "driver"
      type: "string"
      required: true
      description: |
        The driver to leverage for writing in a bucket.
    
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

### Working with blob stores

Once registered, an integration of type `blob` allows to interact with a blob
store for **L**oading data into a bucket. Within a trigger in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-bucket"
            transformation:
              # ...
            config:
              # ...
```
