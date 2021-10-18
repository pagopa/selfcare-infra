#!/usr/bin/env bash

#
# Setup configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./setup.sh ENV-SelfCare
#
#  ./setup.sh DEV-SelfCare
#  ./setup.sh UAT-SelfCare
#  ./setup.sh PROD-SelfCare

BASHDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
WORKDIR="${BASHDIR//scripts/}"

set -e

SUBSCRIPTION=$1

if [ -z "${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription as first argument.\n"
    exit 1
fi

if [ ! -d "${WORKDIR}/subscriptions/${SUBSCRIPTION}" ]; then
    printf "\e[1;31mYou must provide a subscription for which a variable file is defined. You provided: '%s'.\n" "${SUBSCRIPTION}" > /dev/stderr
    exit 1
fi

az account set -s "${SUBSCRIPTION}"

aks_name=$(az aks list -o tsv --query "[?contains(name,'aks')].{Name:name}")
aks_resource_group_name=$(az aks list -o tsv --query "[?contains(name,'aks')].{Name:resourceGroup}")
aks_private_fqdn=$(az aks list -o tsv --query "[?contains(name,'aks')].{Name:privateFqdn}")

# in widows, even if using cygwin, these variables will contain a landing \r character
aks_name=${aks_name//[$'\r']}
aks_resource_group_name=${aks_resource_group_name//[$'\r']}
aks_private_fqdn=${aks_private_fqdn//[$'\r']}

# if using cygwin, we have to transcode the WORKDIR
HOME_DIR=$HOME
if [[ $HOME_DIR == /cygdrive/* ]]; then
  HOME_DIR=$(cygpath -w ~)
  HOME_DIR=${HOME_DIR//\\//}
fi

rm -rf "${HOME}/.kube/config-${aks_name}"
az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${SUBSCRIPTION}" --file "~/.kube/config-${aks_name}"
az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${SUBSCRIPTION}" --overwrite-existing
echo "aks_private_fqdn=${aks_private_fqdn}" >> "${WORKDIR}/subscriptions/${SUBSCRIPTION}/.bastianhost.ini"
echo "kube_config_path=${HOME_DIR}/.kube/config-${aks_name}" >> "${WORKDIR}/subscriptions/${SUBSCRIPTION}/.bastianhost.ini"

# with AAD auth enabled we need to authenticate the machine on the first setup
echo "Follow Microsoft sign in steps. kubectl get pods command will fail but it's the expected behavior"
kubectl --kubeconfig="${HOME_DIR}/.kube/config-${aks_name}" get pods
kubectl config use-context "${aks_name}"
kubectl get pods
