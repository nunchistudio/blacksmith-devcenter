---

gateway:
  values:
    name: "my-bucket"

  schema:
    - key: "filename"
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

    - key: "md5"
      type: "string"
      example: "eabe30e8f540d6c49110a19eae5ce71c"
      description: |
        Specify the MD5 of the file's content for integrity check.

    - key: "meta"
      type: "map[string]string"
      example:
        source: "sdk-js"
      description: |
        Specify a key/value strings to be associated with the file.

---

### Transformation & Load to a bucket

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
