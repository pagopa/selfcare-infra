#!/bin/bash

#
# Renew the JWT token inside the keyvault. After this script you have to be connected to the env VPN and apply the k8s
# module in order to update configMap and secrets and next run the k8s/scripts/restart-pods.sh in order to apply
# the new configuration
#
# Environments are dev, uat or prod
# Usage:
#  ./renew-jwt.sh env jwt_name
#
#  ./renew-jwt.sh dev jwt
#  ./renew-jwt.sh dev jwt_exchange
#  ./renew-jwt.sh dev agid_spid
#  ./renew-jwt.sh dev agid_login

set -e

BASEDIR=$(dirname "$0")

env=$1
jwt_name=$2

if [ -z "$env" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

if [ -z "$jwt_name" ]; then
  echo "jwt_name should be: jwt, jwt_exchange, agid_spid or agid_login."
  exit 0
fi

"$BASEDIR"/../../terraform.sh taint $env module.$jwt_name.tls_private_key.jwt
"$BASEDIR"/../../terraform.sh apply $env -target=module.$jwt_name

printf "\n\n************************************************************************************************\n\n"
echo "Now you have to be connected to env VPN in order to apply k8s module and next run k8s/scripts/restart-pods.sh script"
printf "\n************************************************************************************************"
