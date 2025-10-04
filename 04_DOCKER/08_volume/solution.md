# Volumes

## display volume

`docker volume ls`

# Attach volume

```
docker build -t volume_ls 01_volume_ls
docker run volume_ls
touch /tmp/something
docker run -v /tmp:/data volume_ls /data
```


# Create volume and add :ro flag

```
docker volume create my-volume
docker volume ls
docker run -d -it -v my-volume:/data:ro alpine
docker run -d -it -v my-volume:/data alpine
docker exec -it <?> sh

```
