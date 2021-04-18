#!/bin/bash

if [ $# -ne 1 ]
then
	echo "cleanup.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
helm -n $NAMESPACE del helm-es-security
kubectl -n $NAMESPACE delete pvc security-master-security-master-0 security-master-security-master-1 security-master-security-master-2
exit 0
