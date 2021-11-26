---
title: Your first models
enterprise: false
---

# Your first models

Data validation plays an important role for ensuring the best data quality across
teams and systems. While writing models for validating the data is optional in
Blacksmith, we highly recommend to do so since data reliability and quality from
end-to-end is critical for an organisation.

In the previous guide, we sent some data to the trigger created earlier. What
happens if the data is not good? What happens if `user` is not an object? Or if
`username` is not a string?

Blacksmith leverages the [JSON Schema](https://json-schema.org/) specification
for validating data against a model: each model is a JSON Schema document.

In the ETL pipeline, validating data against a model ensures data quality both at
the trigger level right after **E**xtracting the data, and at the integration level
right before **L**oading the data. In other words, you can set validations *pre*
and *post* **T**ransformation. Without validation, you may try to **L**oad bad
data against an integration. Depending on the behavior of the said integration,
it might break or accept the bad data. Either way, data is broken because it's
either missing or not valid.

## Validation *pre* Transformation

Let's validate the data *before* the **T**ransformation. Once the data is
**E**xtracted, you can validate it against a model by adding a `model` key in the
trigger.

First, generate a new model:
```bash
$ blacksmith generate model \
  --name user \
  --path ./models/users/extraction.json \
  --extend trigger/http_endpoint
```

Here we add the `--extend` flag with `trigger/http_endpoint` as value. The generated
model inherits the schema of a data **E**xtraction from a HTTP endpoint, as defined
in the [Application reference](/blacksmith/tour). This way, you can set validations
not only for the `body`, but also for the `headers`, `query`, etc. passed by the
HTTP request.

We can then add the `model` key with the path to the generated model for validating
the data:
```yml
sources:
  - name: "api"
    # ...
    triggers:
      - name: "new_user"
        # ...
        model: "./models/users/extraction.json"
        integrations:
          # ...
```

This informs that the data **E**xtracted must respect the JSON Schema defined at
the `model` path. If the data doesn't respect the model, the ETL process will stop
since the data that will then be passed down for **T**ransformation would not be
valid. Therefore the data to **L**oad shall not be valid as well.

For our simple use case, the JSON Schema *pre* **T**ransformation shall look like
this:
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "new_user",
  "title": "new_user",
  "description": "JSON schema for validating a HTTP endpoint trigger on `new_user`.",
  "allOf": [{"$ref": "https://nunchi.studio/blacksmith/trigger/http_endpoint"}],
  "properties": {
    "headers": {
      "type": "object",
      "properties": {}
    },
    "query": {
      "type": "object",
      "properties": {}
    },
    "body": {
      "type": "object",
      "properties": {
        "user": {
          "type": "object",
          "properties": {
            "username": {
              "type": "string"
            }
          }
        }
      }
    }
  }
}
```

You can now restart the worker loader and the gateway, and see how the ETL pipeline
reacts with both good and bad data.

## Validation *post* Transformation

Now, let's validate the data *after* the **T**ransformation happened. This aims
to validate the data for each integration, allowing to have a dedicated model
for each of them.

As explained before, a `sql` integration doesn't need the `transformation` inside
a trigger. For the purpose of these guides, let's assume we also have the non-SQL
`nonexisting-nosql` integration, and wish to validate data *before* **L**oading
it.

We would need to generate a new model for **L**oading this kind of data to the
`nonexisting-nosql` integration:
```bash
$ blacksmith generate model \
  --name user \
  --path ./models/users/load.json
```

Then, we would set the path to the model for the integration as the value for
`model`:
```yml
sources:
  - name: "api"
    # ...
    triggers:
      - name: "new_user"
        # ...
        integrations:
          - name: "nonexisting-nosql"
            model: "./models/users/load.json"
            transformation:
              id: "{% uuid %}"
              username: "{% query 'body.user.username' %}"
            config:
              # ...
```

This means the `transformation` object defined for the integration will be tested
against this model. If the validation failed, the data will not be **L**oaded to
the integration.

Following on our example, the model shall look like this:
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "user",
  "title": "user",
  "description": "JSON schema for validating data before Loading to a non-SQL integration.",
  "type": "object",
  "required": ["id", "username"],
  "properties": {
    "id": {
      "type": "string",
      "format": "uuid"
    },
    "username": {
      "type": "string"
    }
  }
}
```

Finally, we can retrieve our users from the database by running a select.
