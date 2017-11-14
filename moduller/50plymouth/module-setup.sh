#!/bin/bash

# called by dracut
check() {
    [[ "$mount_needs" ]] && return 1
    require_binaries plymouthd plymouth plymouth-set-default-theme
}

# called by dracut
depends() {
    echo drm
}

# called by dracut
install() {
    PKGLIBDIR="/usr/lib/plymouth"
    ${PKGLIBDIR}/plymouth-populate-initrd -t "$initdir"

    inst_hook emergency 50 "$moddir"/plymouth-emergency.sh

    inst_multiple readlink

    if ! dracut_module_included "systemd"; then
        inst_hook pre-trigger 10 "$moddir"/plymouth-pretrigger.sh
        inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
    fi
}

