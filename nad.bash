#!/bin/bash

interval=60

function failed()
{
    echo "$*" >&2
    exit 1
}

function is_internet_connected ()
{
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        return 0
    else
        return 1
    fi
}

while true; do
    if ! is_internet_connected ; then
        logger nad.bash ipv4 is down , run netplan apply
        netplan apply
    fi
    sleep ${interval}
done

logger nad.bash exit
