# Minecraft Server

A repo for managing my minecraft server. I use the paper server inside a docker container.

```
make build-image
make up
```

`make up` is just a shorthand for `docker compose up -d`.

You will then need to accept the EULA, which you can do using

```
make inspect-files
```

which will dump you in an Alpine (just because it had `vi` built in) container with the server files mounted at `/server-files`. You can then modify the EULA file to accept it.

After this you will need to restart the container with

```
make up
```

after which everything should run. However, if you wish to modify any settings you can do so by running

```
make inspect-files
```

again.

You can stop the container with

```
make stop
```

.

## Backups

You can backup with

```
make backup
```

which will stop the server (causing it to save changes), run the backup, and restart the server.

You can restore from the most recent backup with

```
make restore
```

If you wish to restore a specific backup, look into how it functions in the makefile.

You can decompress the most recent backup with

```
make view-backup
```

.

## TODO

- Make a systemctl timer backup thingo.
- Make a systemctl timer to thin out old backups
- Do a more rigorous test of a backup restore.