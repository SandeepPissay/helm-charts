#!/bin/bash

if [ $# -ne 1 ]
then
	echo "cleanup.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
kubectl -n $NAMESPACE delete secret kibana || true
helm -n observability del helm-kibana-security
exit 0
