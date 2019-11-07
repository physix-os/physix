#!/bin/bash

source /physix/include.sh
                     
cd /sources
PKG=$1
stripit $PKG
SRCD=$STRIPPED

cd /sources
unpack $PKG
cd /sources/$SRCD

SAVEPATH=$PATH                  &&
PATH=$PATH:/sbin:/usr/sbin      &&
./configure --prefix=/usr       \
            --exec-prefix=      \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-udev_sync  
chroot_check $? "lvm2 : configure"

make                            &&
PATH=$SAVEPATH                  &&
unset SAVEPATH
chroot_check $? "lvm2 : make"

make -C tools install_tools_dynamic &&
make -C udev  install                 &&
make -C libdm install
chroot_check $? "lvm2 : make tools/udev/libdm install"

make check_local
chroot_check $? "lvm2 : make check local" NOEXIT

make install
chroot_check $? "lvm2 : make install"

rm -rf /sources/$SRCD

