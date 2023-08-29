# Copyright (C) 2023 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

PR .= ".1"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://gdbserver_static_build_support.patch"

do_install_append() {
	if [ "${STATIC_GDBSERVER}" != "0" ] ; then
		mv ${D}${bindir}/gdbserver_static ${D}${bindir}/gdbserver
	fi
}
