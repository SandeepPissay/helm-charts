#!/bin/bash

if [ $# -ne 3 ]
then
	echo "setup.sh <supervisor namespace> <tkc name> <tkc namespace>"
	echo "Number of parameters: $#, expected 3. Exiting !!!"
	exit -1
fi
export SV_NAMESPACE=$1
export TKC_NAME=$2
export TKC_NAMESPACE=$3

kubectl -n $SV_NAMESPACE get secret ${TKC_NAME}-kubeconfig -o=jsonpath='{.data.value}' | base64 -d > /tmp/${TKC_NAME}-kubeconfig

if [ $? -ne 0 ]
then
	echo "Secret for $TKC_NAME not found"
	exit 1
fi

export KUBECONFIG=/tmp/${TKC_NAME}-kubeconfig

kubectl create ns $TKC_NAMESPACE && \
	kubectl -n $TKC_NAMESPACE create secret generic elastic-certificate-pem --from-file=/wcp-elk/elasticsearch/examples/security/elastic-certificate.pem && \
	kubectl -n $TKC_NAMESPACE create secret generic elastic-credentials --from-literal=password=elk-operator --from-literal=username=elastic
