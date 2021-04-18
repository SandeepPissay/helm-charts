#!/bin/bash
if [ $# -ne 1 ]
then
	echo "delete_secrets.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
kubectl -n $NAMESPACE delete secrets elastic-credentials elastic-certificates elastic-certificate-pem elastic-certificate-crt|| true
