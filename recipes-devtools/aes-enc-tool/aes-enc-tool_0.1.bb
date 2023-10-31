SUMMARY = "Tool to encrypt images using an 16byte AES key"
DESCRIPTION = "Python3 tool to encrypt the binary using the 16byte AES key"
LICENSE = "Alif"
LIC_FILES_CHKSUM = "file://${ALIFBASE}/licenses/Alif;md5=e5c68df4a3ef4a551f3229bfb6905840"
PR = "r1"

do_install() {
	install -D -m 0755 ${ALIFBASE}/lib/CSPI_AES128_ECB.py \
	${D}${bindir}/CSPI_AES128_ECB.py
}
RDEPENDS_${PN} = "python3-pycryptodome"
BBCLASSEXTEND = "nativesdk"
