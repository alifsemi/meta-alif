SUMMARY = "Linux device drivers test cases"
DESCRIPTION = "a32-linux-DD-testcases contains test cases of various \
Linux device drivers, which verified basic functionality of Linux \
device drivers."
LICENSE="MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r1"

LINUX_DD_TC_BRANCH ?= "bolt-rev-a0"

LINUX_DD_TC_TREE ?= "git://10.10.10.22/a32_linux_DD_testcases.git;protocol=http"

SRC_URI = "${LINUX_DD_TC_TREE};branch=${LINUX_DD_TC_BRANCH}"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"

do_compile(){
    oe_runmake
}

do_install() {
    oe_runmake DESTDIR="${D}" TARGET=install
}

FILES_${PN} = "/opt/linux_dd_test/"

COMPATIBLE_MACHINE = "(bolt.*fpga).*"
