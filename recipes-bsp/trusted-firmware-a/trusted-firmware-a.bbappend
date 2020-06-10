PR .= ".6"

LIC_FILES_CHKSUM_bolt-fpga = "file://license.rst;md5=c709b197e22b81ede21109dbffd5f363"
SRC_URI_bolt-fpga = "git://10.10.10.22/arm-tf.git;protocol=http;branch=bolt-fpga"
SRCREV_bolt-fpga = "${AUTOREV}"

inherit deploy

do_install[noexec] = "1"

do_deploy() {
       [ -f ${B}/${TF-A_PLATFORM}/bl32.bin ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/bl32.bin ${DEPLOYDIR}/bl32.bin
       [ -f ${B}/${TF-A_PLATFORM}/fdts/bolt_fpga.dtb ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/fdts/bolt_fpga.dtb ${DEPLOYDIR}/bolt_fpga.dtb
       install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/fip.bin ${DEPLOYDIR}/${TF-A_PLATFORM}.fip
}

addtask deploy before do_build after do_compile

COMPATIBLE_MACHINE .= "|(bolt-fpga)"
