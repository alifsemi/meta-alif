# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

PR .= ".3"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append += "file://remote_g_packet_error_fix.patch"

do_install_append() {
	install -D -m 0644 ${S}/gdb/features/arm/arm-vfpv3.xml \
	${D}${datadir}/gdb/features/arm-vfpv3.xml
}
