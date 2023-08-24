# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

LICENSE="MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r2"

SRC_URI = "file://helloworld.c \
           file://helloworld-daemon"
PV = "1.0"
S = "${WORKDIR}/"

DEPENDS += "update-rc.d-native"

do_configure[noexec] = "1"

do_compile(){
    ${CC} helloworld.c -o helloworld -static
}

do_install() {
    install -m 755 -D ${S}/helloworld ${D}${bindir}/helloworld
    install -m 755 -D ${WORKDIR}/helloworld-daemon \
                      ${D}${sysconfdir}/init.d/helloworld-daemon
    install -d ${D}/etc/rcS.d/
    update-rc.d -r ${D} helloworld-daemon defaults
}

PACKAGES += "${PN}-daemon"

FILES_${PN} = "${bindir}/helloworld"
FILES_${PN}-daemon = "${sysconfdir}"
INITSCRIPT_PACKAGES = "${PN}-daemon"
INITSCRIPT_NAME_${PN}-daemon = "helloworld-daemon"
