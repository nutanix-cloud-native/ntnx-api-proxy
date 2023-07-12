build:
	docker build -t nxlab.fr/tuxtof/ntnx-api-proxy --platform linux/amd64 .
	docker push nxlab.fr/tuxtof/ntnx-api-proxy