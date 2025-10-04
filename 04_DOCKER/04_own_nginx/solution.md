# Nginx without port exposed

```
docker build -t jsystems-workshop/nginx:noexpose .
```


## Write nginx dockerfile without exposing port in Dockerfile

```
docker run -d -P --name noexpose jsystems-workshop/nginx:noexpose
```

```
docker run -d -p 82:80 --name noexpose jsystems-workshop/nginx:noexpose
```

## Write own html page and provide to nginx

## Run nginx and access it by browser


```
docker rm -f noexpose
```

## Remove other files copied using dockerignore