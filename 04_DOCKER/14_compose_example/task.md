# Compose task


- run both redis and python-api:redis
- redis container should have name `redis` or `REDIS_HOST` should be set in python
- don't expose port on redis


Check network
```
curl 127.0.0.1:5002/healthz
curl -XPOST 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```
