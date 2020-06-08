#!/bin/bash
source /opt/admin/physix/include.sh || exit 1

su physix -c 'make -f unix/Makefile generic_gcc'
chroot_check $? "make"

make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install
chroot_check $? "make install"

