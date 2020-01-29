#!/bin/bash
source /physix/include.sh || exit 1
cd $SOURCE_DIR/xc/$1 || exit 1

./configure $XORG_CONFIG
chroot_check $? "xcb-util-renderutil : config"
make
chroot_check $? "xcb-util-renderutil : make "
make install
chroot_check $? "xcb-util-renderutil : make install"
