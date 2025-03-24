build:
	docker build -t ghcr.io/nutanix-cloud-native/ntnx-api-proxy:dev --platform linux/amd64 .
	docker push ghcr.io/nutanix-cloud-native/ntnx-api-proxy:dev