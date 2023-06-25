#!/bin/bash
# https://github.com/crops/docker-win-mac-docs/wiki/Mac-Instructions
docker volume create --name myvolume
docker run -it --rm -v myvolume:/workdir busybox chown -R 1000:1000 /workdir
docker create -t -p 445:445 --name samba -v myvolume:/workdir crops/samba:selfbuilt
docker start samba && sudo ifconfig lo0 127.0.0.2 alias up
#Open Finder, then hit 'Command-K'. In the "Server Address" box type smb://127.0.0.2/workdir and click "Connect".
docker run --rm -it -v myvolume:/workdir crops/poky:selfbuilt --workdir=/workdir