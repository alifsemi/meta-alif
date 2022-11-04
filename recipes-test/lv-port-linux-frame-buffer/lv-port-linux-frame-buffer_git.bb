# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

SUMMARY = "LVGL configured to work with a standard Linux framebuffer"
HOMEPAGE = "https://github.com/lvgl/lv_port_linux_frame_buffer"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=802d3d83ae80ef5f343050bf96cce3a4"

SRC_URI = "gitsm://github.com/lvgl/lv_port_linux_frame_buffer.git;branch=master;protocol=git \
          file://reduce-size-and-add-basic-app.patch"

SRCREV = "ba8b092b49a8c5eeea29ee32877226909a824aee"

inherit autotools-brokensep

PR = "r1"
S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile () {
    oe_runmake
}
do_install () {
    install -D -m 755 ${B}/demo ${D}${bindir}/demo
}
