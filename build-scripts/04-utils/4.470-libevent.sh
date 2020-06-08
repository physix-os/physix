#!/bin/bash
source /opt/admin/physix/include.sh || exit 1

su physix -c './configure --prefix=/usr --disable-static'
chroot_check $? "libevent : configure"

su physix -c 'make'
chroot_check $? "libevent : make"

make install
chroot_check $? "libevent : make install"

