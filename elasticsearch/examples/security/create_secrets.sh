#!/bin/bash
if [ $# -ne 1 ]
then
	echo "create_secrets.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
password=`< /dev/urandom tr -cd '[:alnum:]' | head -c20`
kubectl -n $NAMESPACE create secret generic elastic-certificates --from-file=elastic-certificates.p12 && \
       kubectl -n $NAMESPACE create secret generic elastic-certificate-pem --from-file=elastic-certificate.pem && \
       kubectl -n $NAMESPACE create secret generic elastic-certificate-crt --from-file=elastic-certificate.crt && \
       kubectl -n $NAMESPACE create secret generic elastic-credentials --from-literal=password=$password --from-literal=username=elastic
