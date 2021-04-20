#!/bin/bash

if [ $# -ne 3 ]
then
	echo "cleanup.sh <supervisor namespace> <tkc name> <tkc namespace>"
	echo "Number of parameters: $#, expected 3. Exiting !!!"
	exit -1
fi
export SV_NAMESPACE=$1
export TKC_NAME=$2
export TKC_NAMESPACE=$3

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

# Ignore helm failure
helm -n $TKC_NAMESPACE del helm-filebeat-security

exit 0
