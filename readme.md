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

## Systemd service and timer

The systemd service and timer files located in `systemd` are very coupled to an assumption of a particular setup of the host machine. That isn't great, but I don't really have any ideas to generalise them, so I just set them to align to my setup.

They assume that there is a user called `minecraft` which is in a group of a corresponding name. They assume that this user controls a clone of this repo at `/opt/minecraft/minecraft-server` (in my setup `/opt/minecraft` is the home directory of the `minecraft` user).

To use them, you will need to manually copy them into `/etc/systemd/system`, as root. You can do this with `sudo cp systemd/* /etc/systemd/system`. You will then need to `systemctl enable` them both and `systemctl start` the timer.

If the service already existed when you copy it in, you will need to run `systemctl daemon-reload` to refresh `systemd`'s knowledge of the source files.

## TODO

- Make a systemctl timer to thin out old backups
- Work out what is going on with replacing timings with spark. I think for now I should just disable timings.
  - https://spark.lucko.me/
  - https://github.com/PaperMC/Paper/issues/8948