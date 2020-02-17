#!/bin/bash
source /physix/include.sh || exit 1
cd $SOURCE_DIR/$1 || exit 1

su physix -c './configure --prefix=/usr'
chroot_check $? "configure"

make install
chroot_check $? 'make install'
