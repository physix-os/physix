#!/bin/bash
source /physix/include.sh || exit 1
cd $SOURCE_DIR/$1 || exit 1

groupadd -g 48 rsyncd &&
useradd -c "rsyncd Daemon" -d /home/rsync -g rsyncd \
    -s /bin/false -u 48 rsyncd
chroot_check $? "rsync : groupadd/useradd " NOEXIT

./configure --prefix=/usr --without-included-zlib
chroot_check $? "rsync : configure"

make
chroot_check $? "rsync: make"

make install
chroot_check $? "rsync : make install"
