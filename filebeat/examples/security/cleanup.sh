#!/bin/bash

if [ $# -ne 1 ]
then
	echo "cleanup.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
# Ignore helm failure
helm -n $NAMESPACE del helm-filebeat-security

# Ignore if create namespace fails for now.
kubectl delete ns $NAMESPACE
exit 0
