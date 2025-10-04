## Run nginx in normal mode

```
docker run --name mynginx nginx
```
## Run nginx in detached mode

```
docker run -d --name mynginx nginx
```

## stop & remove container

```
docker stop mynginx
docker rm mynginx
```

## start container with multiple env variables

```
docker run -d --name mynginx -e user=maciej -e topic=workshops nginx
```

## display env variables

```
docker exec -ti mynginx /bin/bash
```

## Force remove container

```
docker rm -f mynginx
```

## Create Env file
```
echo "user=maciek
szkolenie=devops" > zmienne

docker run -d --name mynginx --env-file zmienne -p 80:80 nginx

curl 127.0.0.1
```

## Generate random port
```
docker run -d --name mynginx2 --env-file zmienne -P nginx

docker port mynginx2

curl 127.0.0.1:<port>
```
