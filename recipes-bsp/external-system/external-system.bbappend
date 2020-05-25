PR .= ".4"

FREERTOS ?= "1"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append += "${@bb.utils.contains('FREERTOS', '1', 'file://0001-Changes-to-compile-framework-with-FreeRTOS.patch', '', d)}"
SRCREV = "CORSTONE-700-2020.02.10"

inherit deploy

do_install[noexec] = "1"

do_deploy() {
    install -D -p -m 0644 ${B}/es_flashfw.bin ${DEPLOYDIR}/es_flashfw.bin
}

addtask deploy before do_build after do_compile

COMPATIBLE_MACHINE .= "|(bolt-fpga)"
