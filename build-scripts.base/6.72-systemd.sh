#!/bin/bash 
# SPDX-License-Identifier: MIT
# Copyright (C) 2019 Travis Davies

source /physix/include.sh                

cd /sources
PKG=$1              
stripit $PKG        
SRCD=$STRIPPED      

PKG1=$2
stripit $PKG1
SRCD1=$STRIPPED

cd /sources         
unpack $PKG
unpack $PKG1
cd /sources/$SRCD   

patch -Np1 -i ../systemd-243-consolidated_fixes-2.patch
chroot_check $? "systemd :"

ln -sf /tools/bin/true /usr/bin/xsltproc
chroot_check $? "systemd :"


for file in /tools/lib/lib{blkid,mount,uuid}.so*; do
    ln -sf $file /usr/lib/
done

tar -xf ../$PKG1
chroot_check $? "systemd :"

sed '177,$ d' -i src/resolve/meson.build &&
sed -i 's/GROUP="render", //' rules/50-udev-default.rules.in
chroot_check $? "systemd :"

mkdir -p build
cd       build

PKG_CONFIG_PATH="/usr/lib/pkgconfig:/tools/lib/pkgconfig" \
LANG=en_US.UTF-8                   \
meson --prefix=/usr                \
      --sysconfdir=/etc            \
      --localstatedir=/var         \
      -Dblkid=true                 \
      -Dbuildtype=release          \
      -Ddefault-dnssec=no          \
      -Dfirstboot=false            \
      -Dinstall-tests=false        \
      -Dkmod-path=/bin/kmod        \
      -Dldconfig=false             \
      -Dmount-path=/bin/mount      \
      -Drootprefix=                \
      -Drootlibdir=/lib            \
      -Dsplit-usr=true             \
      -Dsulogin-path=/sbin/sulogin \
      -Dsysusers=false             \
      -Dumount-path=/bin/umount    \
      -Db_lto=false                \
      -Drpmmacrosdir=no            \
      ..
chroot_check $? "systemd : configure"

LANG=en_US.UTF-8 ninja
chroot_check $? "systemd : ninhja"

LANG=en_US.UTF-8 ninja install
chroot_check $? "systemd : ninja install"

rm -f /usr/bin/xsltproc
chroot_check $? "systemd : rm -f /usr/bin/xsltproc"


systemd-machine-id-setup
chroot_check $? "systemd : systemd-machine-id-setup"

systemctl preset-all
chroot_check $? "systemd : systemctl preset-all"

systemctl disable systemd-time-wait-sync.service
chroot_check $? "systemd : disable systemd-time-wait-sync.service"

rm -f /etc/sysctl.d/50-pid-max.conf 
chroot_check $? "systemd : rm -f /etc/sysctl.d/50-pid-max.conf"
rm -fv /usr/lib/lib{blkid,uuid,mount}.so* 
chroot_check $? "systemd : rm -fv /usr/lib/lib{blkid,uuid,mount}.so*"
rm -f /usr/lib/tmpfiles.d/systemd-nologin.conf 
chroot_check $? "systemd : rm -f /usr/lib/tmpfiles.d/systemd-nologin.conf"


