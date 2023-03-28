DOCKER_IMAGE_NAME=thewrongjames/minecraft-server

PAPER_VERSION=1.19.4
PAPER_BUILD_NUMBER=466
CUSTOM_VERSION=2

VERSION=${PAPER_VERSION}-${PAPER_BUILD_NUMBER}-${CUSTOM_VERSION}

CONTAINER_NAME=minecraft-server_server
VOLUME_NAME=minecraft-server_persistent-files

VIEW_BACKUP_FOLDER=view_backup

.PHONEY: build-image
build-image:
	# Build the current version of the image.
	docker build \
		--tag ${DOCKER_IMAGE_NAME}:latest \
		--tag ${DOCKER_IMAGE_NAME}:${VERSION} \
		--build-arg PAPER_VERSION=${PAPER_VERSION} \
		--build-arg PAPER_BUILD_NUMBER=${PAPER_BUILD_NUMBER} \
		.

.PHONEY: inspect-files
inspect-files:
	# Get a shell in a container with the server files and the repo folder
	# mounted.
	docker run \
		--rm \
		--volume ${VOLUME_NAME}:/server-files \
		--volume `pwd`:/repo \
		--entrypoint /bin/sh \
		--tty \
		--interactive \
		alpine

# Just runs the backup, without bother to stop the container or anything first.
.PHONEY: just-backup
just-backup:
	docker run \
		--rm \
		--volume ${VOLUME_NAME}:/server-files \
		--volume `pwd`/backups:/backups \
		--volume `pwd`/scripts:/scripts \
		ubuntu bash /scripts/backup.sh `id -u` `id -g`


.PHONEY: backup
backup:
	# Stop the container, backup the files, and restart the container.
	docker container stop ${CONTAINER_NAME}
	make just-backup
	docker container start ${CONTAINER_NAME}

.PHONEY: restore
restore:
	docker container stop ${CONTAINER_NAME}
	# Restore the most recent backup.
	docker run \
		--rm \
		--volume ${VOLUME_NAME}:/server-files \
		--volume `pwd`/backups:/backups \
		--volume `pwd`/scripts:/scripts \
		ubuntu bash /scripts/restore.sh
	docker container start ${CONTAINER_NAME}

.PHONEY: view-backup
view-backup:
	# Uncompress the most recent backup.
	rm -rf ${VIEW_BACKUP_FOLDER}
	mkdir ${VIEW_BACKUP_FOLDER}
	tar \
		-xzvf \
		backups/`ls backups -t --width=1 | head -n 1` \
		-C ${VIEW_BACKUP_FOLDER}

.PHONEY: up
up:
	# Start the server, creating it and / or the required volume if they don't
	# exist.
	docker compose up -d

.PHONEY: stop
stop:
	# Stop the server.
	docker container stop ${CONTAINER_NAME}

.PHONEY: update
update:
	# Stop the server, back it up, pull the repo, re-build the image, and restart
	# the server.
	docker container stop ${CONTAINER_NAME}
	make just-backup
	git pull
	make build-image
	docker compose up -d