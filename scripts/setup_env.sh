#!/bin/bash

ROOT=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE}))/..)

DEV_NAME=$(readlink -f $ROOT/CONFIG | sed 's#.*/.*[.]\(.*\)$#\1#')

OUT=$ROOT/out/$DEV_NAME
KOUT=$OUT/kernel.build
BP_OUT=$OUT/backports.build

MESHID=xzmesh

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

adbs_p() {
    ADBS_PARALLEL=1 adbs ${*}
}

adbs() {
    for dev in `list_xperiaz`; do
        local ip=$(gen_ip $dev)
        local cmd=$(echo ${*} | sed "s/@IP@/$ip/")
        if [[ -z $ADBS_PARALLEL ]]; then
            echo adb -s $dev $cmd 1>&2
            eval "adb -s $dev $cmd" | sed 's///g'
        else
            echo '(PARALLEL)' adb -s $dev $cmd 1>&2
            eval "adb -s $dev $cmd" &>/dev/null &
        fi
    done
    wait
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

    if [[ -n $1 ]]; then
        local onlyserial=$1
        echo "Waiting for one phone to reboot: $onlyserial"
    fi

    for xz in `cat $UPTIME_FILE`; do

        local serial=`echo $xz | awk '{print $1}'`
        local uptime=`echo $xz | awk '{print $2}'`

        if [[ -n "$onlyserial" ]] && [[ "$onlyserial" != "$serial" ]]; then
            continue
        fi

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

get_ip()
{
    adb -s $1 shell ip addr show mesh0|sed 's#^M##'|head -3|tail -1|sed 's#.*inet \(.*\)/8 .*#\1#'
}

get_mac()
{
    adb -s $1 shell ip addr show mesh0|sed 's#^M##'|head -2|tail -1|sed 's#.*ether \(.*\) brd .*#\1#'
}

all_join_mesh()
{
    for dev in `list_xperiaz`; do
        join_mesh $1 $2 $dev
    done
}

join_mesh()
{
    local channel=$1
    local ht=$2
    local serial=$3
    local leave=$4

    [[ "NO_HT" == "$ht" ]] && ht=

    (
        if [[ -z $leave ]]; then
            echo_eval adb -s $serial shell iw reg set US
            sleep 0.5
            echo_eval adb -s $serial shell iw reg get
            sleep 0.5
            echo_eval adb -s $serial shell iw phy phy0 interface add mesh0 type mp
            sleep 0.5
            echo_eval adb -s $serial shell iw dev mesh0 set channel $channel $ht
            sleep 0.5
            echo_eval adb -s $serial shell ip link set mesh0 up
            sleep 0.5
        fi

        echo_eval adb -s $serial shell iw dev mesh0 mesh join $MESHID
        sleep 0.5

        if [[ -z $leave ]]; then
            echo_eval adb -s $serial shell ifconfig mesh0 $(gen_ip $serial)
            sleep 0.5
        fi

    ) 1>&2

    get_ip $serial
}

join_mesh_meshkit()
{
    local channel=$1
    local ht=$2
    local serial=$3
    local leave=$4 # not used

    adb -s $serial shell mesh mesh0 up $MESHID $channel $ht 1>&2
    get_ip $serial
}

reboot_one_phone()
{
    local serial=$1
    [[ -n $serial ]] || die 'reboot_one_phone: serial number not specified'
    capture_uptime
    adb -s $serial reboot
    wait_for_adbs $serial
    adb -s $serial 'wait-for-device'
}

reboot_phones()
{
    capture_uptime
    ADBS_PARALLEL=1 adbs reboot

    wait_for_adbs
    adbs 'wait-for-device'
}

declare -a on_exit_items

function on_exit()
{
    for i in "${on_exit_items[@]}"; do
        eval $i
    done
}

function add_on_exit()
{
    local n=${#on_exit_items[*]}
    on_exit_items[$n]="$*"
    if [[ $n -eq 0 ]]; then
        trap on_exit EXIT
    fi
}

function echo_eval() 
{
    echo "$@"
    eval "$@"
}
