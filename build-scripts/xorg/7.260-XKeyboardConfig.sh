#!/bin/bash
source /physix/include.sh || exit 1
source /etc/profile.d/xorg.sh || exit 2
cd $SOURCE_DIR/$1 || exit 3

./configure $XORG_CONFIG --with-xkb-rules-symlink=xorg
chroot_check $? "./configure $XORG_CONFIG"

make 
chroot_check $? "make "

make install
chroot_check $? "make install"
