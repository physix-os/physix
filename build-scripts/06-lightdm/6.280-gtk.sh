#!/bin/bash
source /opt/admin/physix/include.sh || exit 1


ldconfig
su physix -c 'source ~/.profile && env && ./configure --prefix=/usr              \
            --sysconfdir=/etc          \
            --enable-broadway-backend  \
            --enable-x11-backend       \
            --enable-wayland-backend  --libdir=/usr/lib64'
chroot_check $? "configure"

su physix -c 'make'
chroot_check $? "make"

make install
chroot_check $? "make install"

mkdir -vp ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/settings.ini << "EOF"
[Settings]
gtk-theme-name = Adwaita
gtk-icon-theme-name = oxygen
gtk-font-name = DejaVu Sans 12
gtk-cursor-theme-size = 18
gtk-toolbar-style = GTK_TOOLBAR_BOTH_HORIZ
gtk-xft-antialias = 1
gtk-xft-hinting = 1
gtk-xft-hintstyle = hintslight
gtk-xft-rgba = rgb
gtk-cursor-theme-name = Adwaita
EOF

cat > ~/.config/gtk-3.0/gtk.css << "EOF"
*  {
   -GtkScrollbar-has-backward-stepper: 1;
   -GtkScrollbar-has-forward-stepper: 1;
}
EOF

ldconfig
chroot_check $? "ldconfig"

gtk-query-immodules-3.0 --update-cache
chroot_check $? "gtk-query-immodules-3.0"

glib-compile-schemas /usr/share/glib-2.0/schemas
chroot_check $? "glib-compile-schemas"

