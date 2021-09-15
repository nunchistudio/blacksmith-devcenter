---
title: Elasticsearch index
enterprise: true
---

# Elasticsearch index

You can integrate [Elasticsearch](https://www.elastic.co/elasticsearch/) with
Blacksmith to index, search, and discover workflows directly within your Elastic
Stack.

Both Elasticsearch v6 and v7 are supported:
- [Schemas for v6](https://github.com/nunchistudio/blacksmith-devcenter/tree/main/schemas/elasticsearch_v6)
- [Schemas for v7](https://github.com/nunchistudio/blacksmith-devcenter/tree/main/schemas/elasticsearch_v7)

## Creating the index

In order to leverage Elasticsearch, you first need to configure the cluster,
create the template, and the index. 

```bash
$ curl -X PUT "http://127.0.0.1:9200/_cluster/settings" \
  -H "Content-Type: application/json" \
  --data-binary @./schemas/elasticsearch_v7/visibility/v1.0/cluster_settings.json \
  --write-out "\n"

$ curl -X PUT "http://127.0.0.1:9200/_template/blacksmith_v1_visibility_template" \
  -H "Content-Type: application/json" \
  --data-binary @./schemas/elasticsearch_v7/visibility/v1.0/template.json \
  --write-out "\n"

$ curl -X PUT "http://127.0.0.1:9200/blacksmith_v1_visibility" \
  --write-out "\n"
```

In the requests defined above, we assume:
- You run them from the root directory of the [`blacksmith-devcenter`
  repository](https://github.com/nunchistudio/blacksmith-devcenter). If not, you
  need to change the relative path of the JSON files.
- You use Elasticsearch v7. If you use Elasticsearch v6, change `v7` to `v6`.
- The Elasticsearch URL is `http://127.0.0.1:9200`.

When done, you should see the `blacksmith_v1_visibility` indice in the *Index
Management* section:

![Blacksmith index on Elasticsearch](/images/blacksmith/elastic-index.png)

## Configuring Blacksmith

The config file `BLACKSMITH_DIR/services.BLACKSMITH_EXT` must have the following
options to setup Elasticsearch on the Blacksmith server:
```yml
server:
  # ...
  elastic:
    elasticsearch:
      version: "v7"
      log:
        level: "warn"
      sniffing:
        enabled: false
      healthcheck:
        enabled: true
```

Then, you need to set the following environment variable:
```bash
ELASTICSEARCH_URL=http://localhost:9200
```

If you need to authenticate with a username and password, you can do so by setting
these environment variables:
```bash
ELASTICSEARCH_USERNAME=<username>
ELASTICSEARCH_PASSWORD=<password>
```

### With AWS signing

If your Elasticsearch cluster in hosted on AWS, you must enable the AWS signing
like this:
```yml
server:
  # ...
  elastic:
    elasticsearch:
      # ...
      aws:
        signing: true
```

It will automatically use the AWS-reserved environment variables, such as:
```bash
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_REGION=us-east-2
```
