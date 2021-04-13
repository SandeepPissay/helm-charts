default: test

include ../../../helpers/examples.mk

RELEASE := helm-apm-server-security

install:
	helm -n observability upgrade --wait --timeout=$(TIMEOUT) --install --values values.yaml $(RELEASE) ../../

test: install goss

purge:
	helm -n observability del $(RELEASE)
