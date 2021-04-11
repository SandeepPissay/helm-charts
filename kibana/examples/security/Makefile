default: test

include ../../../helpers/examples.mk

RELEASE := helm-kibana-security

install:
	helm -n observability upgrade --wait --timeout=$(TIMEOUT) --install --values values.yaml $(RELEASE) ../../

test: secrets install goss

purge:
	kubectl -n observability delete secret kibana || true
	helm -n observability del $(RELEASE)

secrets:
	encryptionkey=$$(docker run --rm busybox:1.31.1 /bin/sh -c "< /dev/urandom tr -dc _A-Za-z0-9 | head -c50") && \
	kubectl -n observability create secret generic kibana --from-literal=encryptionkey=$$encryptionkey
