#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Usage:
#  ./flyway.sh info|validate|migrate ENV-SelfCare selc
#
#  ./flyway.sh migrate DEV-SelfCare selc
#  ./flyway.sh migrate UAT-SelfCare selc
#  ./flyway.sh migrate PROD-SelfCare selc

BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

COMMAND=$1
SUBSCRIPTION=$2
DATABASE=$3
shift 3
other=$@

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

az account set -s "${SUBSCRIPTION}"

# shellcheck disable=SC2154
printf "Subscription: %s\n" "${SUBSCRIPTION}"

psql_server_name=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:name}" | head -1)
psql_server_private_fqdn=$(az postgres server list -o tsv --query "[?contains(name,'postgresql')].{Name:fullyQualifiedDomainName}" | head -1)
keyvault_name=$(az keyvault list -o tsv --query "[?contains(name,'kv')].{Name:name}")

# in widows, even if using cygwin, these variables will contain a landing \r character
psql_server_name=${psql_server_name//[$'\r']}
psql_server_private_fqdn=${psql_server_private_fqdn//[$'\r']}
keyvault_name=${keyvault_name//[$'\r']}

administrator_login=$(az keyvault secret show --name postgres-administrator-login --vault-name "${keyvault_name}" -o tsv --query value)
administrator_login_password=$(az keyvault secret show --name postgres-administrator-login-password --vault-name "${keyvault_name}" -o tsv --query value)

# in widows, even if using cygwin, these variables will contain a landing \r character
administrator_login=${administrator_login//[$'\r']}
administrator_login_password=${administrator_login_password//[$'\r']}

export FLYWAY_URL="jdbc:postgresql://${psql_server_private_fqdn}:5432/${DATABASE}?sslmode=require"
export FLYWAY_USER="${administrator_login}@${psql_server_name}"
export FLYWAY_PASSWORD="${administrator_login_password}"
export SERVER_NAME="${psql_server_name}"
export FLYWAY_DOCKER_TAG="7.11.1-alpine"

party_user_password=$(az keyvault secret show --name postgres-party-user-password --vault-name "${keyvault_name}" -o tsv --query value)
mock_registry_user_password=$(az keyvault secret show --name postgres-mock-registry-user-password --vault-name "${keyvault_name}" -o tsv --query value)
monitoring_user_password=$(az keyvault secret show --name postgres-monitoring-user-password --vault-name "${keyvault_name}" -o tsv --query value)
monitoring_external_user_password=$(az keyvault secret show --name postgres-monitoring-external-user-password --vault-name "${keyvault_name}" -o tsv --query value)

# in widows, even if using cygwin, these variables will contain a landing \r character
party_user_password=${party_user_password//[$'\r']}
mock_registry_user_password=${mock_registry_user_password//[$'\r']}
monitoring_user_password=${monitoring_user_password//[$'\r']}
monitoring_external_user_password=${monitoring_external_user_password//[$'\r']}

export PARTY_USER_PASSWORD="${party_user_password}"
export MOCK_REGISTRY_USER_PASSWORD="${mock_registry_user_password}"
export MONITORING_USER_PASSWORD="${monitoring_user_password}"
export MONITORING_EXTERNAL_USER_PASSWORD="${monitoring_external_user_password}"

if [[ $WORKDIR == /cygdrive/* ]]; then
  WORKDIR=$(cygpath -w ${WORKDIR})
  WORKDIR=${WORKDIR//\\//}
fi

docker run --rm --network=host -v "${WORKDIR}/migrations/${DATABASE}":/flyway/sql \
  flyway/flyway:"${FLYWAY_DOCKER_TAG}" \
  -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" \
  -validateMigrationNaming=true \
  -placeholders.flywayUser="${administrator_login}" \
  -placeholders.partyUserPassword="${PARTY_USER_PASSWORD}" \
  -placeholders.mockRegistryUserPassword="${MOCK_REGISTRY_USER_PASSWORD}" \
  -placeholders.monitoringUserPassword="${MONITORING_USER_PASSWORD}" \
  -placeholders.monitoringExternalUserPassword="${MONITORING_EXTERNAL_USER_PASSWORD}" \
  -placeholders.serverName="${SERVER_NAME}" "${COMMAND}" ${other}
