#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (C) 2019 Tree Davies
source /mnt/physix/opt/admin/physix/include.sh || exit 1
cd $BR_SOURCE_DIR/$1 || exit 1
source ~/.bashrc

echo $PATH
echo $BUILDROOT_TGT

mkdir -v build
cd       build

../configure                             \
      --prefix=/tools                    \
      --host=$BUILDROOT_TGT              \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=/tools/include

check $? "Glibc Configure"

make
check $? "Glibc make"

make install
check $? "Glibc make install"

#sanity check
echo 'int main(){}' > dummy.c
$BUILDROOT_TGT-gcc dummy.c
check $? "glibc: $BUILDROOT_TGT-gcc dummy.c"

readelf -l a.out | grep ': /tools'
check $? "Glibc: glibc: $BUILDROOT_TGT-gcc dummy.c"

