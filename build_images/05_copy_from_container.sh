#build yocto in container
git clone git://git.yoctoproject.org/poky
cd poky
git branch -a
git checkout -t origin/mickledore -b my-mickledore

source oe-init-build-env
bitbake core-image-sato

docker ps
docker cp <container-id>:workdir/<whatever-you-want-to-copy> .
docker ps
docker exec -it --user=root <container-id> bash