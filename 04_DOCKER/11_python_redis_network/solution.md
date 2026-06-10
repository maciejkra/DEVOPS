# List networks

```
docker network list
```

# Use network

- create new network
- run both redis & python with `--network <name>`
- redis container should have name `redis` or `REDIS_HOST` should be set in python
- don't expose port on redis

```
docker network create python
docker run -d --network python --name redis-service redis:alpine
docker run -d --network python -e REDIS_HOST=redis-service -p 5002:5002 python-api:redis
```


Check network
```
curl 127.0.0.1:5002/healthz
curl -XPOST 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```
