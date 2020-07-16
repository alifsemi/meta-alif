PR .= ".4"

SRCREV = "CORSTONE-700-2020.02.10"
FILESEXTRAPATHS_prepend := "${THISDIR}/files/:"
SRC_URI_append += "file://test-app_es0_mhu0.c \
                   file://test-app_es0_mhu1.c"

do_compile_append(){
    ${CC} ${WORKDIR}/test-app_es0_mhu0.c -o ${S}/test-app_es0_mhu0 --static
    ${CC} ${WORKDIR}/test-app_es0_mhu1.c -o ${S}/test-app_es0_mhu1 --static
    cp ${S}/{test-app_es0_mhu0,test-app_es0_mhu1} ${B}
}

do_install_append() {
    install -m 0755 ${B}/test-app_es0_mhu0 ${D}${bindir}/test-app_es0_mhu0
    install -m 0755 ${B}/test-app_es0_mhu1 ${D}${bindir}/test-app_es0_mhu1
}

COMPATIBLE_MACHINE .= "|(bolt-fpga)"
