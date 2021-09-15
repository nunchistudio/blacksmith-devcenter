CREATE TABLE schema_version (
  version_partition INT not null,
  db_name VARCHAR(255) not null,
  creation_time TIMESTAMP,
  curr_version VARCHAR(64),
  min_compatible_version VARCHAR(64),
  PRIMARY KEY (version_partition, db_name)
);

CREATE TABLE schema_update_history (
  version_partition INT not null,
  year int not null,
  month int not null,
  update_time TIMESTAMP not null,
  description VARCHAR(255),
  manifest_md5 VARCHAR(64),
  new_version VARCHAR(64),
  old_version VARCHAR(64),
  PRIMARY KEY (version_partition, year, month, update_time)
);

INSERT INTO "public"."schema_update_history" ("version_partition", "year", "month", "update_time", "description", "manifest_md5", "new_version", "old_version") VALUES
  (0, 2021, 6, '2021-06-29 10:21:13.63428', 'initial version', '', '0.0', '0'),
  (0, 2021, 6, '2021-06-29 10:21:13.687104', 'base version of visibility schema', '698373883c1c0dd44607a446a62f2a79', '1.0', '0.0'),
  (0, 2021, 6, '2021-06-29 10:21:13.693191', 'add close time & status index', 'e286f8af0a62e291b35189ce29d3fff3', '1.1', '1.0');

INSERT INTO "public"."schema_version" ("version_partition", "db_name", "creation_time", "curr_version", "min_compatible_version") VALUES
  (0, 'blacksmith_visibility', '2021-06-29 10:21:13.691583', '1.1', '0.1');

CREATE TABLE executions_visibility (
  namespace_id CHAR(64) NOT NULL,
  run_id CHAR(64) NOT NULL,
  start_time TIMESTAMP NOT NULL,
  execution_time TIMESTAMP NOT NULL,
  workflow_id VARCHAR(255) NOT NULL,
  workflow_type_name VARCHAR(255) NOT NULL,
  status INTEGER NOT NULL,
  close_time TIMESTAMP NULL,
  history_length BIGINT,
  memo BYTEA,
  encoding VARCHAR(64) NOT NULL,
  task_queue VARCHAR(255) DEFAULT '' NOT NULL,
  PRIMARY KEY  (namespace_id, run_id)
);

CREATE INDEX by_type_start_time ON executions_visibility (namespace_id, workflow_type_name, status, start_time DESC, run_id);
CREATE INDEX by_workflow_id_start_time ON executions_visibility (namespace_id, workflow_id, status, start_time DESC, run_id);
CREATE INDEX by_status_by_start_time ON executions_visibility (namespace_id, status, start_time DESC, run_id);
CREATE INDEX by_type_close_time ON executions_visibility (namespace_id, workflow_type_name, status, close_time DESC, run_id);
CREATE INDEX by_workflow_id_close_time ON executions_visibility (namespace_id, workflow_id, status, close_time DESC, run_id);
CREATE INDEX by_status_by_close_time ON executions_visibility (namespace_id, status, close_time DESC, run_id);
CREATE INDEX by_close_time_by_status ON executions_visibility (namespace_id, close_time DESC, run_id, status);
