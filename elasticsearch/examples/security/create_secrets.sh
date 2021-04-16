if [ $# -ne 1 ]
then
	echo "create_secrets.sh <kube_config_file>"
	echo "Number of parameters: $#, expected 1. Exiting !!!"
	exit -1
fi
export KUBECONFIG=$1
password=`< /dev/urandom tr -cd '[:alnum:]' | head -c20`
kubectl -n observability create secret generic elastic-certificates --from-file=elastic-certificates.p12 && \
       kubectl -n observability create secret generic elastic-certificate-pem --from-file=elastic-certificate.pem && \
       kubectl -n observability create secret generic elastic-certificate-crt --from-file=elastic-certificate.crt && \
       kubectl -n observability create secret generic elastic-credentials --from-literal=password=$password --from-literal=username=elastic
