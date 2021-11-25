---

gateway:
  values:
    name: "my-bucket"

  schema:
    - key: "file"
      type: "string"
      example: "./path/file.json"
      required: true
      description: |
        The path and key to write into the bucket.

    - key: "encoding"
      type: "string"
      example: "gzip"
      description: |
        Specify the encoding used for the file's content, if any.

    - key: "language"
      type: "string"
      example: "en-US"
      description: |
        Specify the language used for the file's content, if any.

    - key: "meta"
      type: "map[string]string"
      example:
        source: "sdk-js"
      description: |
        Specify a key/value strings to be associated with the file.

---

### Load to a bucket

When **L**oading data to a blob store, the JSON returned by the `transformation`
is the one actually **L**oaded into the integration, as the *object*.

Given the example defined above and the `transformation` defined in the example
on the *code* section, the JSON document written into the bucket would be:
```json
{
  "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
  "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
  "sku": "BLACKSMITH_EE",
  "quantity": 1.0
}
```
