if [ $# -ne 1 ]
then
	echo "create_secrets.sh <kube_config_file>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export KUBECONFIG=$1
kubectl -n observability delete secrets elastic-credentials elastic-certificates elastic-certificate-pem elastic-certificate-crt|| true
