# Build my-own image


## Write own html page and provide to nginx image

## Run nginx and access it by browser

## Create password file inside my-own folder

```password
very-secret-password
```

Rebuild image and verify password is there

```
docker container run --rm <?> cat /usr/html/password
```

## Remove other files copied using dockerignore

Create `.dockerignore`

```.dockerignore
*.md
<?>
```

1. Rebuild image
2. Password is no longer there

## Run container and verify new index.html page
