PR .= ".5"

LIC_FILES_CHKSUM_bolt-fpga = "file://license.rst;md5=c709b197e22b81ede21109dbffd5f363"
FILESEXTRAPATHS_prepend := "${THISDIR}/files/:"
SRC_URI_bolt-fpga = "git://${USER}@git.linaro.org/landing-teams/working/arm/arm-tf.git;protocol=https;branch=iota \
file://corstone700.dts \
file://0001-Set-Bolt-FPGA-generic-timer-frequency-to-10Mhz.patch \
file://0002-Set-ARM-boot-uart-clock-freq-to-24Mhz.patch \ 
"
SRCREV_bolt-fpga = "CORSTONE-700-2020.02.10"

inherit deploy

do_compile_prepend () {
    cp -fv ${WORKDIR}/corstone700.dts ${S}/fdts/corstone700.dts
}

do_install[noexec] = "1"

do_deploy() {
       [ -f ${B}/${TF-A_PLATFORM}/bl32.bin ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/bl32.bin ${DEPLOYDIR}/bl32.bin
       [ -f ${B}/${TF-A_PLATFORM}/fdts/corstone700.dtb ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/fdts/corstone700.dtb ${DEPLOYDIR}/corstone700.dtb
       install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/fip.bin ${DEPLOYDIR}/${TF-A_PLATFORM}.fip
}

addtask deploy before do_build after do_compile

COMPATIBLE_MACHINE .= "|(bolt-fpga)"
