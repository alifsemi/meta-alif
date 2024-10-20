# Copyright (C) 2024 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

SUMMARY = "Tool to encrypt images using an 16byte AES key"
DESCRIPTION = "Python3 tool to encrypt the binary using the 16byte AES key"
LICENSE = "Alif"
LIC_FILES_CHKSUM = "file://${ALIFBASE}/licenses/Alif;md5=e5c68df4a3ef4a551f3229bfb6905840"
PR = "r2"

do_install() {
	install -D -m 0755 ${ALIFBASE}/lib/CSPI_AES128_ECB.py \
	${D}${bindir}/CSPI_AES128_ECB.py
}
RDEPENDS:${PN} = "python3-pycryptodome"
BBCLASSEXTEND = "nativesdk"
