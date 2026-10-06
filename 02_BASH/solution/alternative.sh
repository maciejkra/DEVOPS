#!/bin/bash
LOG_FILE=install.log

function log_print () {
    echo "$(date +"%Y_%m_%d %H:%M:%S") $1" >> $LOG_FILE
    echo "$1"
}

function print () {
    echo "$1"
}

function install () {
    apt-get update
    apt-get install --no-install-recommends -y python3 redis python3-pip uvicorn
    cd /root/DEVOPS/01_BASH/Python_app/ || exit 1
    pip3 install --no-cache-dir -r requirements.txt

    cat <<EOF > /lib/systemd/system/python-api.service
[Unit]
Description=Python API
After=network.target

[Service]
WorkingDirectory=/root/DEVOPS/01_BASH/Python_app
Type=simple
Environment=REDIS_HOST=127.0.0.1
ExecStart=/usr/bin/uvicorn main:app --host 0.0.0.0 --port 5002
StandardInput=tty-force

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable python-api.service
    systemctl start python-api.service

    if [ $? != 0 ]; then
        whiptail --title "Błąd" --msgbox "Wystąpił błąd podczas uruchamiania usługi python-api." 10 60
        exit 2
    fi
}

function backup () {
    log_print "Rozpoczynam backup"
    print "Wykonuje backup redis'a"
    redis-cli save > /dev/null
    if [ $? != 0 ]; then
        log_print "Wystąpił błąd podczas tworzenia backupu redis'a"
        whiptail --title "Błąd" --msgbox "Nie udało się wykonać backupu Redis'a!" 10 60
        exit 2
    fi
    mkdir -p /backup
    mv /var/lib/redis/dump.rdb /backup/"$(date +"%Y_%m_%d")"_redis.backup
    log_print "Backup skończony"
    whiptail --title "Sukces" --msgbox "Backup został pomyślnie wykonany!" 10 60
}

function choose_backup_file () {
    local backup_dir="/backup"
    local files=($(ls -1 "$backup_dir"/*.backup 2>/dev/null))

    if [ ${#files[@]} -eq 0 ]; then
        whiptail --title "Brak plików" --msgbox "Nie znaleziono żadnych plików backupu w katalogu $backup_dir" 10 60
        return 1
    fi

    local menu_items=()
    for file in "${files[@]}"; do
        menu_items+=("$file" "$(basename "$file")")
    done

    local selected_file=$(whiptail --title "Wybierz plik backupu" \
        --menu "Wybierz plik do przywrócenia:" 20 78 10 \
        "${menu_items[@]}" \
        3>&1 1>&2 2>&3)

    if [ $? -ne 0 ]; then
        whiptail --title "Anulowano" --msgbox "Operacja przywracania została anulowana." 10 60
        return 1
    fi

    echo "$selected_file"
}

function rollback () {
    log_print "Przywracam backup"

    local selected_file
    selected_file=$(choose_backup_file) || return 1

    log_print "Wybrano plik: $selected_file"

    redis-cli DEL counter > /dev/null
    print "Zatrzymuję Redis'a"
    service redis-server stop || {
        whiptail --title "Błąd" --msgbox "Nie udało się zatrzymać Redis'a!" 10 60
        exit 2
    }

    cp "$selected_file" /var/lib/redis/dump.rdb

    print "Uruchamiam Redis'a"
    service redis-server start || {
        whiptail --title "Błąd" --msgbox "Nie udało się uruchomić Redis'a!" 10 60
        exit 2
    }

    whiptail --title "Sukces" --msgbox "Backup z pliku $(basename "$selected_file") został przywrócony!" 10 60
    log_print "Backup przywrócony z pliku $selected_file"
}

function opperation () {
    case "$choice" in
        1) backup ;;
        2) rollback ;;
        *) whiptail --title "Błąd" --msgbox "Nieznana opcja!" 10 60 ;;
    esac
}

# === MENU główne ===
choice=$(whiptail --title "Wybierz operację" \
    --menu "Co chcesz zrobić?" 20 60 4 \
    "1" "Backup Redis" \
    "2" "Przywróć backup (Rollback)" \
    3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    opperation
else
    whiptail --title "Anulowano" --msgbox "Operacja została anulowana." 10 60
fi
