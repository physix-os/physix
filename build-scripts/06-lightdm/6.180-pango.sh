#!/bin/bash
source /opt/admin/physix/include.sh || exit 1


su physix -c 'mkdir build'
cd build 

su physix -c 'meson --prefix=/usr --sysconfdir=/etc ..' 
chroot_check $? 'meson configurei'

su physix -c 'ninja'
chroot_check $? 'ninja'

ninja install
chroot_check $? 'ninja install'


