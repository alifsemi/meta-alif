# Copyright (C) 2026 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r0"
SRC_URI = "file://filesystem_test.c"
PV = "1.0"
S = "${WORKDIR}"
do_configure[noexec] = "1"

do_compile(){
    ${CC} ${CFLAGS} ${LDFLAGS} ${CPPFLAGS} filesystem_test.c -o filesystem_test
}

do_install() {
    install -m 755 -D ${S}/filesystem_test ${D}${bindir}/filesystem_test
}

FILES:${PN} = "${bindir}/filesystem_test"
