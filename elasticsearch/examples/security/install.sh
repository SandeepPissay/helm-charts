#!/bin/bash

if [ $# -ne 1 ]
then
	echo "install.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
helm -n $NAMESPACE upgrade --wait --debug --timeout=1200s --install --values values.yaml helm-es-security ../../
