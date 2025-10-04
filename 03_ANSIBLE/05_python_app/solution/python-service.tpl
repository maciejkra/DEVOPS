[Unit]
Description=Python API
After=network.target
[Service]
WorkingDirectory={{ python_app_dir }}
Type=simple
Environment=REDIS_HOST=127.0.0.1
ExecStart=/usr/bin/uvicorn main:app --host 0.0.0.0 --port 5002
StandardInput=tty-force
[Install]
WantedBy=multi-user.target