#!/usr/bin/env bash

#
# Apply the configuration relative to a given subscription
# Subscription are defined in ./env
# Usage:
#  ./terraform.sh apply|destroy|plan ENV
#
#  ./terraform.sh apply dev
#  ./terraform.sh apply uat
#  ./terraform.sh apply prod

# shellcheck disable=SC2124,SC1090,SC2086

BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="$BASHDIR"

set -e

action=$1
env=$2
shift 2
other=$@

if [ -z "${env}" ]; then
    printf "\e[1;31mYou must provide a subscription as second argument.\n"
    exit 1
fi

if [ ! -d "${WORKDIR}/env/${env}" ]; then
    printf "\e[1;31mYou must provide a subscription for which a variable file is defined. You provided: '%s'.\n" "${env}" > /dev/stderr
    exit 1
fi

aks_private_fqdn=""
kube_config_path=""

# shellcheck disable=SC1090
source "${WORKDIR}/env/${env}/backend.ini"

az account set -s "${subscription}"

export TF_VAR_k8s_apiserver_port="443"
export TF_VAR_k8s_apiserver_host="${aks_private_fqdn}"
export TF_VAR_k8s_kube_config_path="${kube_config_path}"
export HELM_DEBUG=1

# init terraform backend
terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"

# if using cygwin, we have to transcode the WORKDIR
if [[ $WORKDIR == /cygdrive/* ]]; then
  WORKDIR=$(cygpath -w $WORKDIR)
fi

if echo "plan apply refresh import output destroy" | grep -w ${action} > /dev/null; then
  if [ "${action}" = "output" ]; then
    terraform "${action}" $other
  else
    terraform "${action}" --var-file="./env/${env}/terraform.tfvars" $other
  fi
else
    echo "Action not allowed."
    exit 1
fi
