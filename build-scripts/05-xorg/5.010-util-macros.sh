#!/bin/bash
source /opt/admin/physix/include.sh
source /etc/profile.d/xorg.sh || exit 2


su physix -c "./configure $XORG_CONFIG"
chroot_check $? "configure"

make install
chroot_check $? "make install"

