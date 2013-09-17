#!/bin/bash

D=`dirname $(readlink -f ${BASH_SOURCE})`
export PATH=$D/sony-tools:$PATH
