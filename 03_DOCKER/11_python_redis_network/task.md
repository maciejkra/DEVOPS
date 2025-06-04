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

# How redis handle data

- list volume - find one created by redis
*Use  container inspect*
```
-f "{{ (index .Mounts 0) }}"
```
- STOP container
- wait...
- Remove container

- find mount point with inspect using
*Use image inspect*
```
 -f "{{.ContainerConfig.Volumes}}"
```
- create redis again attached to volume - check counter

# Clean up
- remove containers

- list network
- prune network

- list volumes
- prune volumes
