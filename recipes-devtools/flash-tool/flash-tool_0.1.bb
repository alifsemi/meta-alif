Summary = "OSPI1 NOR flash programmer tool for A32"
DESCRIPTION = "This tool programs OSPI1 NOR flash with the \
given images from the Linux userspace"
HOMEPAGE = "https://alifsemi.com/"
SECTION = "console/tools"
LICENSE = "Alif"
LIC_FILES_CHKSUM = "file://${ALIFBASE}/licenses/Alif;md5=e5c68df4a3ef4a551f3229bfb6905840"
PR = "r0"
SRC_URI = "file://flash-tool.c"
do_configure[noexec] = "1"

do_compile() {
	${CC} -Wall -Werror ${WORKDIR}/flash-tool.c -o ${WORKDIR}/flash-tool
}

do_install() {
	install -D -m 0755 ${WORKDIR}/flash-tool ${D}${bindir}/flash-tool
}
LDFLAGS = ""
