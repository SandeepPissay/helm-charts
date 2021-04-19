#!/bin/bash

if [ $# -ne 1 ]
then
	echo "cleanup.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
helm -n $NAMESPACE del helm-apm-server-security
exit 0
