# Minecraft Server

A repo for managing my minecraft server. I use the paper server inside a docker container.

```
make build-image
docker compose up -d
```

The `-d` means to run the container in the background, so you can keep your terminal.

You will then need to accept the EULA, which you can do using

```
make inspect-files
```

which will dump you in an Alpine (just because it had `vi` built in) container with the server files mounted at `/server-files`. You can then modify the EULA file to accept it.

After this you will need to restart the container with

```
docker compose up -d
```

after which everything should run. However, if you wish to modify any settings you can do so by running

```
make inspect-files
```

again.

Stopping the container through docker doesn't gracefully stop the server for some reason, so always stop the server with

```
docker container attach minecraft-server_server
stop
```

.

## Backups

You can backup with

```
make backup
```

and restore with

```
make restore
```

which will restore the most recent backup. If you wish to restore a specific backup, look into how it functions in the makefile.

You can decompress the most recent backup with

```
make view-backup
```

.