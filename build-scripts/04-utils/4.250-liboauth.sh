#!/bin/bash
source /opt/admin/physix/include.sh || exit 1

su physix -c 'patch -Np1 -i ../liboauth-1.0.3-openssl-1.1.0-3.patch'
chroot_check $? "liboauth : patch"

su physix -c './configure --prefix=/usr --disable-static'
chroot_check $? "liboauth : cofnigure"

su physix -c 'make'
chroot_check $? "liboauth : make"

make install
chroot_check $? "liboauth : make install"

