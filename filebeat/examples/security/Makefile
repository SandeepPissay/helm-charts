default: test

include ../../../helpers/examples.mk

RELEASE := helm-filebeat-security

install:
	helm -n vmware-system-beats upgrade --wait --timeout=$(TIMEOUT) --install --values values.yaml $(RELEASE) ../../

test: install goss

purge:
	helm -n vmware-system-beats del $(RELEASE)
