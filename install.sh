#!/usr/bin/env bash

LOG_DIR=$PWD/logs
DB_DIR=$PWD/db
ILOG=$LOG_DIR/install.log

mkdir -p $LOG_DIR $DB_DIR

status_check() {
    if [ $? -eq 0 ]
    then
        echo -e "$1 - Installed"
    else
        echo -e "$1 - Failed!"
    fi
}

debian_install() {
    echo -e '\nINSTALLING FOR DEBIAN\n' > "$ILOG"

    echo -ne 'Python3\r'
    sudo apt -y install python3 python3-pip &>> "$ILOG"
    status_check Python3
    echo -e '\n--------------------\n' >> "$ILOG"

    echo -ne 'PIP\r'
    sudo apt -y install python3-pip &>> "$ILOG"
    status_check Pip
    echo -e '\n--------------------\n' >> "$ILOG"

    echo -ne 'PHP\r'
    sudo apt -y install php &>> "$ILOG"
    status_check PHP
    echo -e '\n--------------------\n' >> "$ILOG"
}

termux_install() {
    echo -e '\nINSTALLING FOR TERMUX\n' > "$ILOG"
    
    echo -ne 'Cloudflared\r'
    apt -y install cloudflared &>> "$ILOG"
    status_check cloudflared
    echo -e '\n--------------------\n' >> "$ILOG"
    
    echo -ne 'Proot\r'
    pkg install proot resolv-conf -y  &>> "$ILOG"
    status_check proot
    echo -e '\n--------------------\n' >> "$ILOG"

    echo -ne 'Python3\r'
    apt -y install python &>> "$ILOG"
    status_check Python3
    echo -e '\n--------------------\n' >> "$ILOG"

    echo -ne 'PHP\r'
    apt -y install php &>> "$ILOG"
    status_check PHP
    echo -e '\n--------------------\n' >> "$ILOG"
}

echo -e '[!] Installing Dependencies...\n'


if [ "$OSTYPE" == 'linux-android' ]; then
	termux_install
else
	debian_install
fi


echo -ne 'Requests\r'
pip3 install requests &>> "$ILOG"
status_check Requests
echo -e '\n--------------------\n' >> "$ILOG"

echo -ne 'Packaging\r'
pip3 install packaging &>> "$ILOG"
status_check Packaging
echo -e '\n--------------------\n' >> "$ILOG"

echo -e '\nCOMPLETED\n' >> "$ILOG"

echo -e '\n[+] Log Saved :' "$ILOG"
