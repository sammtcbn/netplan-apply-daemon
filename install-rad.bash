#!/bin/bash

SERVICE_NAME=rad.service

function failed()
{
    echo "$*" >&2
    exit 1
}

cp -f rad.bash /usr/local/bin || failed "install fail"
cp -f rad-uninstall.bash /usr/local/bin || failed "install fail"

cp -f ${SERVICE_NAME} /etc/systemd/system || failed "install fail"
systemctl daemon-reload || failed "install fail"
chmod 664 /etc/systemd/system/${SERVICE_NAME} || failed "install fail"
chown root.root /etc/systemd/system/${SERVICE_NAME} || failed "install fail"
systemctl enable ${SERVICE_NAME} || failed "install fail"
systemctl start ${SERVICE_NAME} || failed "install fail"

echo "install done"
