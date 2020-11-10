PR .= ".4"

SRCREV = "CORSTONE-700-2020.02.10"
FILESEXTRAPATHS_prepend := "${THISDIR}/files/:"
SRC_URI_append += "file://test-app_es0_mhu0.c \
                   file://test-app_es0_mhu1.c \
                   file://pthread_mhu0_inloop.c \
                   file://pthread_mhu1_inloop.c \
                   file://pthread_se_mhu0_inloop.c \
                   file://pthread_se_mhu1_inloop.c"

do_compile_append(){
    ${CC} ${WORKDIR}/test-app_es0_mhu0.c -o ${S}/test-app_es0_mhu0 --static
    ${CC} ${WORKDIR}/test-app_es0_mhu1.c -o ${S}/test-app_es0_mhu1 --static
    ${CC} ${WORKDIR}/pthread_mhu0_inloop.c -o ${S}/pthread_mhu0_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_mhu1_inloop.c -o ${S}/pthread_mhu1_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_se_mhu0_inloop.c -o ${S}/pthread_se_mhu0_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_se_mhu1_inloop.c -o ${S}/pthread_se_mhu1_inloop -lpthread --static
    cp ${S}/{test-app_es0_mhu0,test-app_es0_mhu1,pthread_mhu0_inloop,pthread_mhu1_inloop,pthread_se_mhu0_inloop,pthread_se_mhu1_inloop} ${B}
}

do_install_append() {
    install -m 0755 ${B}/test-app_es0_mhu0 ${D}${bindir}/test-app_es0_mhu0
    install -m 0755 ${B}/test-app_es0_mhu1 ${D}${bindir}/test-app_es0_mhu1
    install -m 0755 ${B}/pthread_mhu0_inloop ${D}${bindir}/pthread_mhu0_inloop
    install -m 0755 ${B}/pthread_mhu1_inloop ${D}${bindir}/pthread_mhu1_inloop
    install -m 0755 ${B}/pthread_se_mhu0_inloop ${D}${bindir}/pthread_se_mhu0_inloop
    install -m 0755 ${B}/pthread_se_mhu1_inloop ${D}${bindir}/pthread_se_mhu1_inloop
}

COMPATIBLE_MACHINE .= "|(bolt-fpga)"
