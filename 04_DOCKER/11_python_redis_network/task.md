# List networks

```
<??> network <?>
```

# Use network

- create new network
- run both redis & python with `--network <name>`
- redis container should have name `redis` or `REDIS_HOST` should be set in python to point redis container name (container should be named)
- don't expose port on redis


Check network
```
curl 127.0.0.1:5002/healthz
curl -XPOST 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```
