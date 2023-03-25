DOCKER_IMAGE_NAME=thewrongjames/minecraft-server

PAPER_VERSION=1.19.4
PAPER_BUILD_NUMBER=466
CUSTOM_VERSION=1

VERSION=${PAPER_VERSION}-${PAPER_BUILD_NUMBER}-${CUSTOM_VERSION}

VIEW_BACKUP_FOLDER=view_backup

.PHONEY: build-image
build-image:
	docker build \
		--tag ${DOCKER_IMAGE_NAME}:latest \
		--tag ${DOCKER_IMAGE_NAME}:${VERSION} \
		--build-arg PAPER_VERSION=${PAPER_VERSION} \
		--build-arg PAPER_BUILD_NUMBER=${PAPER_BUILD_NUMBER} \
		.

.PHONEY: inspect-files
inspect-files:
	docker run \
		--rm \
		--volume minecraft-server_persistent-files:/server-files \
		--entrypoint /bin/sh \
		--tty \
		--interactive \
		alpine

.PHONEY: backup
backup:
	docker run \
		--rm \
		--volume minecraft-server_persistent-files:/server-files \
		--volume `pwd`/backups:/backups \
		--volume `pwd`/scripts:/scripts \
		ubuntu bash /scripts/backup.sh `id -u` `id -g`

.PHONEY: restore
restore:
	docker run \
		--rm \
		--volume minecraft-server_persistent-files:/server-files \
		--volume `pwd`/backups:/backups \
		--volume `pwd`/scripts:/scripts \
		ubuntu bash /scripts/restore.sh

.PHONEY: view-backup
view-backup:
	rm -rf ${VIEW_BACKUP_FOLDER}
	mkdir ${VIEW_BACKUP_FOLDER}
	tar \
		-xzvf \
		backups/`ls backups -t --width=1 | head -n 1` \
		-C ${VIEW_BACKUP_FOLDER}
