DOCKER_IMAGE_NAME=thewrongjames/minecraft-server

PAPER_VERSION=1.19.4
PAPER_BUILD_NUMBER=466

RAM=3G

.PHONEY: build-image
build-image:
	docker build \
		--tag ${DOCKER_IMAGE_NAME}:latest \
		--tag ${DOCKER_IMAGE_NAME}:${PAPER_VERSION}-${PAPER_BUILD_NUMBER} \
		--build-arg PAPER_VERSION=${PAPER_VERSION} \
		--build-arg PAPER_BUILD_NUMBER=${PAPER_BUILD_NUMBER} \
		.

.PHONEY: create-container
create-container:
	docker container create \
		--volume `pwd`/server-files:/opt/server-files \
		--publish 25565:25565 \
		--env RAM=${RAM} \
		${DOCKER_IMAGE_NAME}:latest
