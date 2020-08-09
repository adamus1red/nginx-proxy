.SILENT :
.PHONY : test-debian test-alpine test


update-dependencies:
	test/requirements/build.sh

test-debian: update-dependencies
	docker buildx build --pull  --platform linux/amd64,linux/386,linux/arm64,linux/ppc64le,linux/s390x --platform  -t jwilder/nginx-proxy:test .
	test/pytest.sh

test-alpine: update-dependencies
	docker buildx build --pull  --platform linux/amd64,linux/386,linux/arm64,linux/ppc64le,linux/s390x -f Dockerfile.alpine -t jwilder/nginx-proxy:test .
	test/pytest.sh

test-mainline:update-dependencies
	docker buildx build --pull  --platform linux/amd64,linux/386,linux/arm64,linux/ppc64le,linux/s390x -f Dockerfile.mainline -t jwilder/nginx-proxy:test .
	test/pytest.sh
	
test-mainline-alpine:update-dependencies
	docker buildx build --pull  --platform linux/amd64,linux/386,linux/arm64,linux/ppc64le,linux/s390x -f Dockerfile.mainline.alpine -t jwilder/nginx-proxy:test .
	test/pytest.sh

test: test-debian test-alpine test-mainline-alpine test-mainline
