#!/bin/bash
source /physix/include.sh || exit 1
cd $SOURCE_DIR/$1 || exit 1

make -f unix/Makefile generic
chroot_check $? "unzip : make generic"

make prefix=/usr MANDIR=/usr/share/man/man1 \
 -f unix/Makefile install
chroot_check $? "unzip : make install"
