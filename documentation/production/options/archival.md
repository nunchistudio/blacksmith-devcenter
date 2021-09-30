---
title: Retention and archival
enterprise: false
---

# Retention and archival

Blacksmith stores workflows' data per the configured retention period of each
namespace. When the retention period of a workflow is met and the workflow has
succeeded or has been canceled, the data related to the workflow is automatically
moved from the persistence database to a long-term storage (bucket).

By using a persistence store (PostgreSQL) for *hot data* and a bucket for archived
workflows, you are able to preserve workflows' data indefinitely while still
using the most appropriate storage system. Therefore, there is no need to set a
very high retention period such as `8760h` (365 days) as your *hot data* mostly
last less than a month.

Blacksmith supports the following archival drivers:
- `local` (default) for archiving on disk. It is not suited for production use.
- `aws/s3` for leveraging AWS S3.
- `google/storage` for leveraging Google Cloud Storage.
