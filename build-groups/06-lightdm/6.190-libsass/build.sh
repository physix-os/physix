#!/bin/bash
source ../include.sh || exit 1
source /etc/profile.d/xorg.sh || exit 2

prep() {
	return 0
}

config() {
	autoreconf -fi
	chroot_check $? 'autoconf'

	./configure --prefix=/usr --disable-static
	chroot_check $? 'make'
}

build() {
	make
	chroot_check $? 'make'
}

build_install() {
	make install
	chroot_check $? 'make install'
}


[ $1 == 'prep' ]   && prep   && exit $?
[ $1 == 'config' ] && config && exit $?
[ $1 == 'build' ]  && build  && exit $?
[ $1 == 'build_install' ] && build_install && exit $?


