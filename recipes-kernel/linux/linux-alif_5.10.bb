# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

ALIF_KERNEL_BRANCH ?= "devkit-ex-b0-5.10.y"

PR = "r12"

require recipes-kernel/linux/linux-yocto.inc
require recipes-kernel/linux/linux-alif.inc

ALIF_KERNEL_TREE ?= "git://10.10.10.22/linux.git;protocol=http"

SRC_URI = "${ALIF_KERNEL_TREE};branch=${ALIF_KERNEL_BRANCH}"

KCONFIG_MODE="--alldefconfig"
SRCREV = "${ALIF_KERNEL_BRANCH}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_VERSION_SANITY_SKIP = "1"
BB_GENERATE_MIRROR_TARBALLS = "0"

LINUX_VERSION ?= "5.10.141"

PV = "${LINUX_VERSION}+git${SRCPV}"

S = "${WORKDIR}/git"

#do_kernel_configme() {
#}

COMPATIBLE_MACHINE = "(devkit-e).*"
