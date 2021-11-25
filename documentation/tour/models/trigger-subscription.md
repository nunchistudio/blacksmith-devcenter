---

resources:
  - parent: "Getting started"
    title: "Your first models"
    link: "/blacksmith/start/discover/models"
    icon: "magnifyWithPlus"
  - parent: "Production best practices"
    title: "Well-defined models"
    link: "/blacksmith/production/options/models"
    icon: "listAdd"

---

### Validation *pre* Transformation

Data validation plays an important role for ensuring the best data quality across
teams and systems. While writing models for validating the data is optional in
Blacksmith, we highly recommend to do so since data reliability and quality from
end-to-end is critical for an organisation.

Blacksmith leverages the [JSON Schema](https://json-schema.org/) specification
for validating data against a model: each model is a JSON Schema document.

In the ETL pipeline, validating data against a model ensures data quality both at
the trigger level right after **E**xtracting the data, and at the integration level
right before **L**oading the data. In other words, you can set validations *pre*
and *post* **T**ransformation. Without validation, you may try to **L**oad bad
data against an integration. Depending on the behavior of the said integration,
it might break or accept the bad data. Either way, data is broken because it's
either missing or not valid.

By setting the `$ref`, the model of the **E**xtraction for a trigger in mode
`subscription` extends the following base JSON Schema:
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://nunchi.studio/blacksmith/trigger/subscription",
  "title": "Subscription",
  "description": "Base JSON Schema for validating a Blacksmith trigger of mode `subscription`.",
  "type": "object",
  "required": [
    "status", "meta", "body"
  ],
  "additionalProperties": false,
  "properties": {
    "status": {
      "description": "The status of the Extraction.",
      "type": "string",
      "enum": ["success", "failure"]
    },
    "meta": {
      "description": "The metadata of the message received by the broker, if any.",
      "type": "object"
    },
    "body": {
      "description": "The JSON body of the message received by the broker.",
      "type": "object"
    }
  }
}
```
