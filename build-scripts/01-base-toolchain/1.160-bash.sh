#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (C) 2019 Tree Davies
source /mnt/physix/opt/admin/physix/include.sh || exit 1
cd $BR_SOURCE_DIR/$1 || exit 1
source ~/.bashrc
whoami

./configure --prefix=/tools --without-bash-malloc
check $? "bash Configre"

make -j8
check $? "bash make"

#make tests
#check $? "bash make tests" NOEXIT

make install
check $? "bash  make install"

ln -sfv bash /tools/bin/sh
check $? "bash: ln -sv bash /tools/bin/sh"

