CREATE TABLE IF NOT EXISTS mock_registry.akka_projection_offset_store (
  projection_name VARCHAR(255) NOT NULL,
  projection_key VARCHAR(255) NOT NULL,
  current_offset VARCHAR(255) NOT NULL,
  manifest VARCHAR(4) NOT NULL,
  mergeable BOOLEAN NOT NULL,
  last_updated BIGINT NOT NULL,
  PRIMARY KEY(projection_name, projection_key)
);

CREATE INDEX IF NOT EXISTS projection_name_index ON mock_registry.akka_projection_offset_store (projection_name);

ALTER TABLE mock_registry.akka_projection_offset_store OWNER TO "MOCK_REGISTRY_USER";

CREATE TABLE IF NOT EXISTS mock_registry.akka_projection_management (
  projection_name VARCHAR(255) NOT NULL,
  projection_key VARCHAR(255) NOT NULL,
  paused BOOLEAN NOT NULL,
  last_updated BIGINT NOT NULL,
  PRIMARY KEY(projection_name, projection_key)
);

ALTER TABLE mock_registry.akka_projection_management OWNER TO "MOCK_REGISTRY_USER";