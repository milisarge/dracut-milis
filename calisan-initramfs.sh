#!/bin/sh
# şifreli luks,ağdan dosya sistemi yükleme ve çalışan imaj destekleri
dracut -N --force --xz --add 'crypt dmsquash-live pollcdrom livenet' --omit systemd  initrd.img `uname -r`
