ALIF_KERNEL_BRANCH ?= "bolt-fpga-b0-5.10.y"

PR = "r9"

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
DEPENDS += "python3-pycryptodome-native"

PV = "${LINUX_VERSION}+git${SRCPV}"

S = "${WORKDIR}/git"

#do_kernel_configme() {
#}

COMPATIBLE_MACHINE = "(bolt.*fpga).*"
