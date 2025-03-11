build:
	docker build -t harbor.infrastructure.cloudnative.nvdlab.net/nutanix-dev/ntnx-api-proxy --platform linux/amd64 .
	docker push harbor.infrastructure.cloudnative.nvdlab.net/nutanix-dev/ntnx-api-proxy