#!/bin/bash
source /opt/admin/physix/include.sh || exit 1

su physix -c "make -j$NPROC"
chroot_check $? "make"

su physix -c "sed -i '/find/s:/usr/bin/::' tests/Makefile" 
su physix -c "make -k test"

make install
chroot_check $? "make install"

