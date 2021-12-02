--
-- Roles
--

CREATE ROLE "PARTY_USER";
ALTER ROLE "PARTY_USER" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
GRANT "PARTY_USER" TO "${flywayUser}";
ALTER USER "PARTY_USER" WITH PASSWORD '${partyUserPassword}';

CREATE ROLE "ATTRIBUTE_REGISTRY_USER";
ALTER ROLE "ATTRIBUTE_REGISTRY_USER" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
GRANT "ATTRIBUTE_REGISTRY_USER" TO "${flywayUser}";
ALTER USER "ATTRIBUTE_REGISTRY_USER" WITH PASSWORD '${attributeRegistryUserPassword}';

CREATE ROLE "MONITORING_USER";
ALTER ROLE "MONITORING_USER" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
ALTER USER "MONITORING_USER" WITH PASSWORD '${monitoringUserPassword}';

CREATE ROLE "MONITORING_EXTERNAL_USER";
ALTER ROLE "MONITORING_EXTERNAL_USER" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
ALTER USER "MONITORING_EXTERNAL_USER" WITH PASSWORD '${monitoringExternalUserPassword}';

-- Database privileges
--

GRANT CONNECT ON DATABASE selc TO "PARTY_USER";
GRANT CONNECT ON DATABASE selc TO "ATTRIBUTE_REGISTRY_USER";
GRANT CONNECT ON DATABASE selc TO "MONITORING_USER";
GRANT CONNECT ON DATABASE selc TO "MONITORING_EXTERNAL_USER";

-- schema creation
--

CREATE SCHEMA party;
ALTER SCHEMA party OWNER TO "PARTY_USER";

CREATE SCHEMA attribute_registry;
ALTER SCHEMA attribute_registry OWNER TO "ATTRIBUTE_REGISTRY_USER";

-- schema grants
--

ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT ALL PRIVILEGES ON TABLES TO "PARTY_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT USAGE ON SEQUENCES TO "PARTY_USER";

ALTER DEFAULT PRIVILEGES IN SCHEMA attribute_registry GRANT ALL PRIVILEGES ON TABLES TO "ATTRIBUTE_REGISTRY_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA attribute_registry GRANT USAGE ON SEQUENCES TO "ATTRIBUTE_REGISTRY_USER";

GRANT USAGE ON SCHEMA party TO "MONITORING_USER";
GRANT USAGE ON SCHEMA attribute_registry TO "MONITORING_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO "MONITORING_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT SELECT ON TABLES TO "MONITORING_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA attribute_registry GRANT SELECT ON TABLES TO "MONITORING_USER";

GRANT USAGE ON SCHEMA party TO "MONITORING_EXTERNAL_USER";
GRANT USAGE ON SCHEMA attribute_registry TO "MONITORING_EXTERNAL_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO "MONITORING_EXTERNAL_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT SELECT ON TABLES TO "MONITORING_EXTERNAL_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA attribute_registry GRANT SELECT ON TABLES TO "MONITORING_EXTERNAL_USER";