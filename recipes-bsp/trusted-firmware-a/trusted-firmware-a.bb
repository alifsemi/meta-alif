SUMMARY = "Trusted Firmware for Cortex-A"
DESCRIPTION = "Trusted Firmware-A"
HOMEPAGE = "https://github.com/ARM-software/arm-trusted-firmware"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"
DEPENDS += " dtc-native coreutils-native"
DEPENDS += " ${TF-A_DEPENDS} "
PR = "r17"

TFA_BRANCH ?= "fpga-b0"

TFA_TREE ?= "git://10.10.10.22/arm-trusted-firmware.git;protocol=http"

SRC_URI = "${TFA_TREE};branch=${TFA_BRANCH}"
SRCREV = "${AUTOREV}"

TF-A_DEPENDS ?= ""
S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

LDFLAGS[unexport] = "1"

TF-A_PLATFORM ?= "fvp"
TF-A_ARCH ?= "aarch32"
TF-A_DEBUG ?= "1"
TF-A_AARCH32_SP ?= "sp_min"
TF-A_BL33 ?= ""

TF-A_TARGET_IMAGES ?= "bl32"
TF-A_EXTRA_OPTIONS ?= ""

inherit deploy

do_compile() {
    rm -rf ${B}
    mkdir -p ${B}

    oe_runmake -C ${S} BUILD_BASE=${B} \
      BUILD_PLAT=${B}/${TF-A_PLATFORM}/ \
      PLAT=${TF-A_PLATFORM} \
      DEBUG=${TF-A_DEBUG} \
      ARCH=${TF-A_ARCH} \
      CROSS_COMPILE=${TARGET_PREFIX} \
      AARCH32_SP=${TF-A_AARCH32_SP} \
      BL33=${TF-A_BL33} \
      ENABLE_AES=${ENABLE_AES} AES_ENC_KEY=${AES_ENC_KEY} \
      ${TF-A_EXTRA_OPTIONS} \
      ${TF-A_TARGET_IMAGES}
}


do_install() {
        [ -f ${B}/${TF-A_PLATFORM}/bl32.bin ] && cp -f ${B}/${TF-A_PLATFORM}/bl32.bin ${D}/bl32.bin
}

do_deploy() {
       [ -f ${D}/bl32.bin ] && install -D -p -m 0644 ${D}/bl32.bin ${DEPLOYDIR}/bl32.bin
}

addtask deploy before do_build after do_install

FILES_${PN} = "/bl32.bin"

COMPATIBLE_MACHINE = "(bolt.*fpga).*"
