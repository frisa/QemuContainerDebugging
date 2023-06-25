docker ps
docker cp <container-id>:workdir/<whatever-you-want-to-copy> .
docker ps
docker exec -it --user=root <container-id> bash