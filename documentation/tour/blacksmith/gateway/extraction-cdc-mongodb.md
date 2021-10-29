---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      example: "mongodb://<url>,<url>,<url>/?replicaSet=<replica>"
      required: true
      description: |
        The MongoDB URL of the replica set to connect to for leveraging MongoDB
        Change Streams.

gateway:
  trigger:
    values:
      stream: "<db>/<collection>"
      params:
        operations:
          - "insert"
          - "update"
          - "replace"
          - "delete"

---

### Configuring MongoDB

[MongoDB Change Streams](https://docs.mongodb.com/manual/changeStreams/) in
Blacksmith let you subscribe to all data changes on a single collection.

On `insert`, `update`, and `replace` operations, the **E**xtraction returned
follows the schema:
```json
{
  "status": "success",
  "id": "826177F3AC0000000...",
  "target": "mydatabase/users",
  "operation": "insert",
  "body": {
    "_id": "6177b0815a4b95fbfa69fcc7",
    "<key>": "<value>"
  }
}
```

The `id` is the unique identifier for the change stream event, and is not the `_id`
of the document related to the event. `body` is the new document inserted, updated,
or replaced.

On `delete` operations, the `body` returned only contains the `_id` of the deleted
document. The JSON returned by the trigger shall therefore look like this:
```json
{
  "status": "success",
  "id": "826177F3AC0000000...",
  "target": "mydatabase/users",
  "operation": "delete",
  "body": {
    "_id": "6177b0815a4b95fbfa69fcc7"
  }
}
```

If no `params.operations` are set, all operations `insert`, `update`, `replace`,
and `delete` will be **E**xtracted.
