LICENSE="MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r0"

SRC_URI = "file://helloworld.c"
PV = "1.0"
S = "${WORKDIR}/"

do_configure[noexec] = "1"

do_compile(){
    ${CC} helloworld.c -o helloworld -static
}

do_install() {
    install -m 755 -D ${S}/helloworld ${D}${base_sbindir}/init
}

FILES_${PN} = "${base_sbindir}"
