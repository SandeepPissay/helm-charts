#!/bin/bash

if [ $# -ne 4 ]
then
	echo "install.sh <supervisor namespace> <tkc name> <tkc namespace> <elasticsearch IP address>"
	echo "Number of parameters: $#, expected 4. Exiting !!!"
	exit -1
fi
export SV_NAMESPACE=$1
export TKC_NAME=$2
export TKC_NAMESPACE=$3
export ES_IPADDRESS=$4

kubectl -n $SV_NAMESPACE get secret ${TKC_NAME}-kubeconfig -o=jsonpath='{.data.value}' | base64 -d > /tmp/${SV_NAMESPACE}###${TKC_NAME}-kubeconfig

if [ $? -ne 0 ]
then
	echo "Secret for $TKC_NAME not found"
	exit 1
fi

cat /tmp/${SV_NAMESPACE}###${TKC_NAME}-kubeconfig
grep "${TKC_NAME}-admin" /tmp/${SV_NAMESPACE}###${TKC_NAME}-kubeconfig
if [ $? -ne 0 ]
then
	echo "kubeconfig for $TKC_NAME in $SV_NAMESPACE is incorrect."
	exit 1
fi

# Set KUBECONFIG to TKC.
export KUBECONFIG=/tmp/${SV_NAMESPACE}###${TKC_NAME}-kubeconfig

sed -e "s/%ELASTICSEARCH_IPADDRESS%/$ES_IPADDRESS/g" -e "s/%TKC_NAME%/$TKC_NAME/g" values.yaml > /tmp/${SV_NAMESPACE}###${TKC_NAME}-metricbeat-values.yaml && \
	helm -n $TKC_NAMESPACE repo add stable https://charts.helm.sh/stable && \
	helm -n $TKC_NAMESPACE dependency update ../../ && \
	helm -n $TKC_NAMESPACE upgrade --wait --debug --timeout=1200s --install --values /tmp/${SV_NAMESPACE}###${TKC_NAME}-metricbeat-values.yaml helm-metricbeat-security ../../
