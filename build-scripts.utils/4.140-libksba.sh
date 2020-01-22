#!/bin/bash
source /physix/include.sh || exit 1
source /physix/build.conf || exit 1
cd $SOURCE_DIR/$1 || exit 1

su physix -c './configure --prefix=/usr'
chroot_check $? "libksba : configure "

su physix -c 'make'
chroot_check $? "libksba : make"
make install
chroot_check $? "libksba : make install"

