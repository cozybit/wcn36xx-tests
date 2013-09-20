#!/bin/bash

ROOT=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE}))/..)
OUT=$ROOT/out/xperiaz

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
