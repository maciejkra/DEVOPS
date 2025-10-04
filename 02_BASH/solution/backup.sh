#!/bin/bash
LOG_FILE=install.log
function log_print () {
    echo "`date +"%Y_%m_%d %H:%M:%S"` $1" >> $LOG_FILE
    echo "$1"
}
function print () {
    echo "$1"
}
function install () {
    apt-get update
    apt-get install --no-install-recommends -y python3 redis python3-pip uvicorn
    cd /root/DEVOPS/01_BASH/Python_app/
    pip3 install --no-cache-dir -r requirements.txt
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
    if [ $? != 0 ]
    then
        echo "wystąpił błąd"
        exit 2
    fi
}
function backup () {
    log_print "Rozpoczynam backup"
    print "Wykonuje backup redis'a"
    redis-cli save > /dev/null
    if [ $? != 0 ]
    then
        log_print "wystąpił błąd podczas tworzenia backupu redis'a"
        exit 2
    fi
    mkdir -p /backup
    mv /var/lib/redis/dump.rdb /backup/`date +"%Y_%m_%d"`_redis.backup
    log_print "Backup skończony"
}
function rollback () {
    log_print "Przywracam backup"
    log_print "Kasuje stary counter"
    redis-cli DEL counter > /dev/null
    print "zatrzymuje redis'a"
    service redis-server stop
    if [ $? != 0 ]
    then
        log_print "wystąpił błąd zatrzymywania redis'a"
        exit 2
    fi
    mv /backup/*.backup /var/lib/redis/dump.rdb
    print "Uruchamiam redisa"
    service redis-server start
    if [ $? != 0 ]
    then
        log_print "wystąpił błąd uruchamiania redis'a"
        exit 2
    fi
    log_print "Backup przywrócony"
}
function opperation () {
    case "$choice" in
        "1") backup ;;
        "2") rollback ;;
        *) echo "Funkcja przyjmuje parametry rollback lub backup"
    esac
}
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
$DIALOG --clear --title "Wykonaj operacje jaka chcesz wykonać" \
        --menu "wybierz operacje:" 20 51 4 \
        1 "backup"  \
        2 "rollback" 2> $tempfile
retval=$?
choice=`cat $tempfile`
case $retval in
  0)
    opperation ;;
  1)
    echo "Cancel pressed.";;
  255)
    echo "ESC pressed.";;
esac