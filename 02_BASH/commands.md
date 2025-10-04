## Installation commands

```sh
apt-get update
apt-get install --no-install-recommends -y python3 redis python3-pip uvicorn
```

### In the application dir
```sh
pip3 install --no-cache-dir -r requirements.txt --break-system-packages
```

### To run the app

Enter the dir with the app `Python_app`
Define REDIS_HOST env and run the app
```sh
export REDIS_HOST=127.0.0.1
uvicorn main:app --host 0.0.0.0 --port 5002
```

Application is running on port 5002 and delivers to endpoints

`/healthz`

`/api/v1/info`

### Test if the application is running

```
curl 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```

### Make a service out of this app
```
echo "[Unit]
Description=Python API
After=network.target

[Service]
WorkingDirectory=/root/DEVOPS/01_BASH/Python_app
Type=simple
Environment=REDIS_HOST=127.0.0.1
ExecStart=/usr/bin/uvicorn main:app --host 0.0.0.0 --port 5002
StandardInput=tty-force

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/python-api.service

systemctl daemon-reload
systemctl enable python-api.service
systemctl start python-api.service
```
