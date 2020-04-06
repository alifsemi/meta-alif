PR .= ".3"

SRCREV_bolt-tiny = "CORSTONE-700-2020.02.10"

inherit deploy

do_install[noexec] = "1"

do_deploy() {
       [ -f ${B}/${TF-A_PLATFORM}/bl1.bin ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/bl1.bin ${DEPLOYDIR}/bl1.bin
       [ -f ${B}/${TF-A_PLATFORM}/bl1/bl1.elf ] && install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/bl1/bl1.elf ${DEPLOYDIR}/bl1.elf
       install -D -p -m 0644 ${B}/${TF-A_PLATFORM}/fip.bin ${DEPLOYDIR}/${TF-A_PLATFORM}.fip
}

addtask deploy before do_build after do_compile
