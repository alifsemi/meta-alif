PR .= ".4"

inherit deploy

SRCREV = "CORSTONE-700-2020.02.10"

do_install[noexec] = "1"

do_deploy() {
        install -D -p -m 0644 ${B}/se_ramfw.bin ${DEPLOYDIR}/se_ramfw.bin
        install -D -p -m 0644 ${B}/se_romfw.bin ${DEPLOYDIR}/se_romfw.bin
        ${B}/spitoc --seram ${DEPLOYDIR}/se_ramfw.bin --offset 1  --fip ${DEPLOY_DIR_IMAGE}/${TF-A_PLATFORM}.fip --offset  33 --out ${DEPLOYDIR}/spitoc.bin
}

do_deploy[depends] += "trusted-firmware-a:do_deploy"
addtask deploy before do_build after do_compile


COMPATIBLE_MACHINE .= "|(bolt-fpga)"
