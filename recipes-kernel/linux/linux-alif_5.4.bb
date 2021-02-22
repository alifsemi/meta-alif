ALIF_KERNEL_BRANCH ?= "bolt-5.4.y"

require recipes-kernel/linux/linux-yocto.inc
require recipes-kernel/linux/linux-alif.inc

ALIF_KERNEL_TREE ?= "git://10.10.10.22/linux.git;protocol=http"

SRC_URI = "${ALIF_KERNEL_TREE};branch=${ALIF_KERNEL_BRANCH} \
           file://defconfig"

KCONFIG_MODE="--alldefconfig"
SRCREV = "${ALIF_KERNEL_BRANCH}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

KERNEL_VERSION_SANITY_SKIP = "1"
BB_GENERATE_MIRROR_TARBALLS = "0"

PR = "r5"
LINUX_VERSION ?= "5.4.25"
PV = "${LINUX_VERSION}+git${SRCPV}"

S = "${WORKDIR}/git"

#do_kernel_configme() {
#}

COMPATIBLE_MACHINE = "bolt-rev-a0"
