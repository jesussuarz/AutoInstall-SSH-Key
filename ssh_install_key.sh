#!/bin/bash

echo "                            ###                         "
echo "                             ##                         "
echo "  ### ##   ####    ######    ##       ####    ######    "
echo " ##  ##   ##  ##    ##  ##   #####   ##  ##    ##  ##   "
echo " ##  ##   ##  ##    ##  ##   ##  ##  ######    ##       "
echo "  #####   ##  ##    #####    ##  ##  ##        ###      "
echo "     ##    ####     ##      ###  ##   #####   #####     "
echo " #####             ####                                 "
echo ""

if [ $EUID -ne 0 ]; then 
    echo 'Run this script under root'
    exit 1;
fi

case "$1" in
    --help|help|-h)
        echo ""
        echo "Usage: $0 add/remove";
        echo ""
        exit 0;
        ;;
esac

KEY=''
flag=$1;
if [ "$flag" == 'add' ]; then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    touch ~/.ssh/authorized_keys
    IS_EXIST=$(cat ~/.ssh/authorized_keys | grep -w gopherssh)
    if [ "${IS_EXIST}" == "" ]; then
        echo "Downloading SSH key..."
        wget https://clientes.gophergroup.com.co/repo/id_rsa.pub -O /tmp/gopherssh-rsa-key >/dev/null 2>&1
        #cp id_rsa.pub /tmp/gopherssh-rsa-key
        echo "Downloading SHA Checksum..."
        wget https://clientes.gophergroup.com.co/repo/id_rsa.checksum -O /tmp/gopherssh-rsa-key-checksum >/dev/null 2>&1
        #cp id_rsa.checksum /tmp/gopherssh-rsa-key-checksum
        CHECKSUM=$(cat /tmp/gopherssh-rsa-key-checksum | awk '{ print $1 }')
        KEYSUM=$(md5sum /tmp/gopherssh-rsa-key | awk '{ print $1 }')
        if [ "${CHECKSUM}" == "${KEYSUM}" ]; then
            KEY=$(cat /tmp/gopherssh-rsa-key)
            echo -n "Installing key: [                    ]"
            echo -ne "\rInstalling key: [####                ]"
            sleep 1
            echo -ne "\rInstalling key: [########            ]"
            sleep 1
            echo -ne "\rInstalling key: [############        ]"
            sleep 1
            echo -ne "\rInstalling key: [####################]"
            sleep 1
            echo -ne "\r"
            echo "${KEY}" >> ~/.ssh/authorized_keys
            rm -f /tmp/gopherssh-rsa-key
            rm -f /tmp/gopherssh-rsa-key-checksum
            echo "Key installed"
        else
            echo "Could not install Key. Checksum failed."
        fi
    else
        echo "Key is already installed"
    fi
    chmod 600 ~/.ssh/authorized_keys

elif [ "$flag" == 'remove' ]; then
    IS_EXIST=$(cat ~/.ssh/authorized_keys | grep -w gopherssh)
    if [ "${IS_EXIST}" == "" ]; then
        echo "Key not found"
    else
        echo -n "Removing key: [                    ]"
        echo -ne "\rRemoving key: [####                ]"
        sleep 1
        echo -ne "\rRemoving key: [########            ]"
        sleep 1
        echo -ne "\rRemoving key: [############        ]"
        sleep 1
        echo -ne "\rRemoving key: [####################]"
        sleep 1
        echo -ne "\r"
        sed -i '/gopherssh/ d' ~/.ssh/authorized_keys
        echo "Key removed"
    fi
else
    echo "Usage: $0 add/remove"
fi
