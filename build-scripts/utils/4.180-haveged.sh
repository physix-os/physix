#!/bin/bash
source /physix/include.sh || exit 1
cd $SOURCE_DIR/$1 || exit 1

su physix -c './configure --prefix=/usr'
chroot_check $? "haveged : configure"

su physix -c 'make'
chroot_check $? "haveged : make"

make install &&
mkdir -pv    /usr/share/doc/haveged-1.9.2 &&
cp -v README /usr/share/doc/haveged-1.9.2
chroot_check $? "haveged : make install"

#init script for boot
#make install-haveged
