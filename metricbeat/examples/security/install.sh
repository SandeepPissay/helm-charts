#!/bin/bash

if [ $# -ne 1 ]
then
	echo "install.sh <namespace>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export NAMESPACE=$1
helm -n $NAMESPACE repo add stable https://charts.helm.sh/stable && \
	helm -n $NAMESPACE dependency update ../../ && \
	helm -n $NAMESPACE upgrade --wait --debug --timeout=1200s --install --values values.yaml helm-metricbeat-security ../../
