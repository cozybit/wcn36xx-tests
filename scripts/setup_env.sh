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
xperiaz=$(
      adb devices 2>&1 \
    | sed 's///g'    \
    | grep 'device'    \
    | cut -d$'\t' -f1  \
    | grep '^BX'       )

adbs() {
    for dev in $xperiaz; do
        ip=$(gen_ip $dev)
        cmd=$(echo ${*} | sed "s/@IP@/$ip/")
        echo adb -s $dev $cmd 1>&2
        adb -s $dev $cmd | sed 's///g'
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
