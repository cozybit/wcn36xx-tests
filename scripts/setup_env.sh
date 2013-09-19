#!/bin/bash

ROOT=$(readlink -f $(dirname $(readlink -f ${BASH_SOURCE}))/..)
OUT=$ROOT/out/xperiaz

export PATH=$ROOT/prebuilts:$PATH

source $ROOT/CONFIG

fastboot() {
    sudo $ROOT/prebuilts/fastboot ${*}
}
