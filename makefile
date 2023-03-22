RAM=3G
PAPER_VERSION=1.19.4
PAPER_BUILD_NUMBER=466

.PHONEY: build
build:
	docker build \
		--build-arg RAM=${RAM} \
		--build-arg PAPER_VERSION=${PAPER_VERSION} \
		--build-arg PAPER_BUILD_NUMBER=${PAPER_BUILD_NUMBER} \
		.