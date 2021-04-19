#!/bin/bash

if [ $# -ne 1 ]
then
	echo "install.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
kubectl create ns $NAMESPACE && \
 	kubectl -n $NAMESPACE create secret generic elastic-certificate-pem --from-file=/wcp-elk/elasticsearch/examples/security/elastic-certificate.pem && \
	kubectl -n $NAMESPACE create secret generic elastic-credentials --from-literal=password=elk-operator --from-literal=username=elastic
 	helm -n $NAMESPACE upgrade --wait --debug --timeout=1200s --install --values values.yaml helm-filebeat-security ../../
