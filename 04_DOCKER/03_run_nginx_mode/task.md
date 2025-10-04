## Run nginx image

1. What heppened?
2. Press `<ctrl+c>`

## Run nginx in detached mode

```sh
<??> -d <??>
```

## stop & remove container

From now run each container in detached mode

## run container with multiple env variables

` -e <key>=<value>`

One of env variable should be `user=<your name>`

## Inspect container & find its ip

`docker inspect <?> -f "{{.NetworkSettings.IPAddress}}"`

Execute proper curl command against container

## display env variables

1. Enter inside container
```sh
<??> exec -ti <??> /bin/bash
```
2. Display env
3. Show user
```sh
echo $user
```
4. Dispaly env without going into bash

## Force remove container

`--force`

## Create Env file

```envfile
<?>=<?>
```

## Run container with env file and forward host port

`--env-file <?>`
`-p <host_port>:<container_port>`

Open browser with `<host_ip>:<host_port>`

## Generate random port

`-P`

## Find port

`<??> port <?>`

Open browser with `<host_ip>:<generated_port>`
