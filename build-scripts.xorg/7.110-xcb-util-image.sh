#!/bin/bash
source /physix/include.sh
cd $SOURCE_DIR/xc/$1 || exit 1

./configure $XORG_CONFIG
chroot_check $? "xcb-util-image : config"
make
chroot_check $? "xcb-util-image : make "
make install
chroot_check $? "xcb-util-image : make install"
