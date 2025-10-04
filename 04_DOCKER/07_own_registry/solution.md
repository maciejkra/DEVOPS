# Run registry container

```
docker run -d -p 5000:5000 registry:2
```

# Curl should work

`curl 127.0.0.1:5000/v2/_catalog`

expected result
```js
{"repositories":[]}
```

# Tag one of your previous images to match 

Use 127.0.0.1 address!

```sh
docker image tag alpine 127.0.0.1:5000/alpine
```

# Push image to new repostiory

```
docker push 127.0.0.1:5000/alpine
```

Expected result after completed task

`curl 127.0.0.1:5000/v2/_catalog`

expected result
```js
{"repositories":["YOUR_IMAGE"]}
```

# Using IP of host without tls

`vim /etc/docker/daemon.json`
```daemon.json
{"insecure-registries":["192.168.0.125:5000"]}
```

```sh
systemctl restart docker
docker container start registry
```

# Consider 

1. Restart container when docker starts `--restart=always`
2. volume mount at: `/var/lib/registry`

For more production case read:
1. https://docs.docker.com/registry/deploying/
2. https://docs.docker.com/registry/configuration/#letsencrypt