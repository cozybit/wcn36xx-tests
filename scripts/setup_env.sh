#!/bin/bash

ROOT=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE}))/..)
OUT=$ROOT/out/xperiaz
KOUT=$OUT/kernel.build
BP_OUT=$OUT/backports.build

export PATH=$ROOT/prebuilts:$PATH

source $ROOT/CONFIG

fastboot() {
    sudo $ROOT/prebuilts/fastboot ${*}
}

# print message and exit the script                                             
# usage: die <message>                                                          
function die () {                                                               
    echo ${*}                                                               
    exit -1                                                                 
}   

# perform a command quietly unless debugging is enabled.i
# usage: Q <anything>
function Q () {
        if [ "${VERBOSE}" == "1" ]; then
                $*
        else
                $* &> /dev/null
        fi
}

# grab a list of Xperia X phones
list_xperiaz() {
      adb devices 2>&1 \
    | sed 's///g'    \
    | grep 'device'    \
    | cut -d$'\t' -f1  \
    | egrep "${XZ_SERIAL}"
}

adbs() {
    while getopts "p" options; do
        case $options in
            p) local parallel=1; shift;;
        esac
    done
    for dev in `list_xperiaz`; do
        local ip=$(gen_ip $dev)
        local cmd=$(echo ${*} | sed "s/@IP@/$ip/")
        if [[ -z $parallel ]]; then
            echo adb -s $dev $cmd 1>&2
            eval "adb -s $dev $cmd" | sed 's///g'
        else
            echo '(PARALLEL)' adb -s $dev $cmd 1>&2
            eval "adb -s $dev $cmd" &>/dev/null &
        fi
    done
}

gen_ip()
{
    local serial=$1

    ip1=`printf "%d" \'${serial: -3: 1}`
    ip2=`printf "%d" \'${serial: -2: 1}`
    ip3=`printf "%d" \'${serial: -1: 1}`

    ip="10.$ip1.$ip2.$ip3"
    echo $ip
}

sleep_countdown() {
    local count=$1
    local msg=$2
    local current=0
    echo -n "$msg"
    while [[ $current -lt $count ]]; do
        sleep 1
        echo -n "."
        current=$(($current + 1))
    done
    echo
}

wait_for_fastboot() {
    local serial=$1
    local once=
    while ! fastboot devices | grep -q $serial; do
        if [[ -z $once ]]; then
            echo -n 'Waiting for fastboot'; once=1
        fi
        echo -n '.'; sleep 0.5
    done
    if [[ ! -z $once ]]; then
        echo
    fi
}

wait_for_adb() {
    local serial=$1
    local once=
    while ! adb devices | grep -q $serial; do
        if [[ -z $once ]]; then
            echo -n 'Waiting for adb'; once=1
        fi
        echo -n '.'; sleep 0.5
    done
    if [[ ! -z $once ]]; then
        echo
    fi
}

UPTIME_FILE=

capture_uptime() {
    UPTIME_FILE=`tempfile`
    for xz in `list_xperiaz`; do
        uptime=`adb -s $xz shell cat /proc/uptime|sed 's###g'|awk '{print $1}'`
        echo $xz $uptime >>$UPTIME_FILE
    done
}

wait_for_adbs() {

    trap "IFS=$IFS" EXIT
    IFS=$'\n'

    for xz in `cat $UPTIME_FILE`; do

        local serial=`echo $xz | awk '{print $1}'`
        local uptime=`echo $xz | awk '{print $2}'`

        echo "Serial: $serial, last uptime: $uptime"

        while `true`; do

            local new_uptime=`adb -s $serial shell cat /proc/uptime 2>&1 | awk '{print $1}'`
            if [[ ! $new_uptime =~ ^[[:digit:]][[:digit:]]*[.][[:digit:]][[:digit:]]*$ ]]; then
                sleep 0.5
                continue
            fi

            local new_uptime=`echo $new_uptime | sed 's/[.][0-9]*$//'`
            local uptime=`echo $uptime | sed 's/[.][0-9]*$//'`

            if [[ $new_uptime -ge $uptime ]]; then
                sleep 0.5
                continue
            fi

            echo "Got new uptime: $new_uptime"
            break

        done

    done
}

join_mesh()
{
    local channel=$1
    local ht=$2

    adbs shell iw reg set US
    adbs shell iw phy phy0 interface add mesh0 type mp
    adbs shell iw dev mesh0 set channel $channel $ht
    sleep 0.5
    adbs shell ip link set mesh0 up
    adbs shell iw dev mesh0 mesh join xz
    sleep 0.5
    adbs shell ifconfig mesh0 @IP@
    sleep 0.5
}

reboot_phones()
{
    capture_uptime
    adbs -p reboot

    wait_for_adbs
    adbs 'wait-for-device'
}
