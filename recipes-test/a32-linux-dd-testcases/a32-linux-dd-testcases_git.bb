# Copyright (C) 2024 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

SUMMARY = "Linux device drivers test cases"
DESCRIPTION = "a32-linux-DD-testcases contains test cases of various \
Linux device drivers, which verified basic functionality of Linux \
device drivers."
LICENSE="Alif"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e5c68df4a3ef4a551f3229bfb6905840"
PR = "r13"
SRC_URI = "${LINUX_DD_TC_TREE};branch=${LINUX_DD_TC_BRANCH}"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"
S = "${WORKDIR}/git"
LDFLAGS = ""

do_configure[noexec] = "1"

do_compile(){
    oe_runmake
}

do_install() {
    oe_runmake DESTDIR="${D}" TARGET=install
}

PACKAGES =. "${PN}-cdc200 ${PN}-hwsem ${PN}-watchdog ${PN}-mhu ${PN}-crc ${PN}-utimer libmhuservices libmhuservices-dev "
FILES:${PN}-cdc200 = "/opt/linux_dd_test/cdc200"
FILES:${PN}-hwsem = "/opt/linux_dd_test/hwsem"
FILES:${PN}-watchdog = "/opt/linux_dd_test/watchdog"
FILES:${PN}-mhu = "/opt/linux_dd_test/mhu/services* /opt/linux_dd_test/mhu/main"
FILES:${PN}-crc = "/opt/linux_dd_test/crc"
FILES:${PN}-utimer = "/opt/linux_dd_test/utimer"
FILES:libmhuservices = "${libdir}/libservices.so.*"
FILES:libmhuservices-dev = "${libdir}/libservices.so"
FILES:${PN} = "/opt/linux_dd_test/mhu/pthread* /opt/linux_dd_test/mhu/test*"
