docker volume create --name yoctovolume
docker run -it --rm -v yoctovolume:/workdir gmacario/build-yocto sudo chown -R build:build /workdir
