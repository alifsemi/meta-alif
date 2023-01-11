# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
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
PR = "r9"

LINUX_DD_TC_BRANCH ?= "devkit-ex-b0"

LINUX_DD_TC_TREE ?= "git://10.10.10.22/a32_linux_DD_testcases.git;protocol=http"

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

PACKAGES =. "${PN}-cdc200 ${PN}-hwsem ${PN}-watchdog ${PN}-mhu ${PN}-crc libmhuservices libmhuservices-dev ${PN}-pcm "
FILES_${PN}-cdc200 = "/opt/linux_dd_test/cdc200"
FILES_${PN}-hwsem = "/opt/linux_dd_test/hwsem"
FILES_${PN}-watchdog = "/opt/linux_dd_test/watchdog"
FILES_${PN}-mhu = "/opt/linux_dd_test/mhu/services* /opt/linux_dd_test/mhu/main"
FILES_${PN}-crc = "/opt/linux_dd_test/crc"
FILES_${PN}-pcm = "/opt/linux_dd_test/pcm"
FILES_libmhuservices = "${libdir}/libservices.so.*"
FILES_libmhuservices-dev = "${libdir}/libservices.so"
FILES_${PN} = "/opt/linux_dd_test/mhu/pthread* /opt/linux_dd_test/mhu/test*"
