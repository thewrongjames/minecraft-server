# Minecraft Server

A repo for managing my minecraft server. I use the paper server inside a docker container.

```
make build-image
make create-container
docker container start <name or ID of container>
```

The ID of the container will be output from `make create-container`, and the name (and other details) of the container can be retrieved with `docker container ls -a`.

To do:
- Backup system