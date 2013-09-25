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
