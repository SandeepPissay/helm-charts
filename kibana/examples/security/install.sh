#!/bin/bash
if [ $# -ne 1 ]
then
	echo "install.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
encryptionkey=`< /dev/urandom tr -dc _A-Za-z0-9 | head -c50` && \
	kubectl -n $NAMESPACE create secret generic kibana --from-literal=encryptionkey=$encryptionkey && \
	helm -n $NAMESPACE upgrade --wait --debug --timeout=1200s --install --values values.yaml helm-kibana-security ../../

