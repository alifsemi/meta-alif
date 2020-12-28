SUMMARY = "CORSTONE700 Host Test App"
DESCRIPTION = "CORSTONE700 Host Test App"
LICENSE="BSD"
LIC_FILES_CHKSUM = "file://license.md;md5=e44b2531cd6ffe9dece394dbe988d9a0"
DEPENDS += " coreutils-native "
PR = "r5"

SRC_URI = "git://${USER}@git.linaro.org/landing-teams/working/arm/test-apps.git;protocol=https;branch=master \
           file://test-app_es0_mhu0.c \
           file://test-app_es0_mhu1.c \
           file://pthread_mhu0_inloop.c \
           file://pthread_mhu1_inloop.c \
           file://pthread_se_mhu0_inloop.c \
           file://pthread_se_mhu1_inloop.c"
SRCREV = "CORSTONE-700-2020.02.10"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"
PLATFORM = "corstone700"

LDFLAGS[unexport] = "1"

do_compile(){
    mkdir -p ${B}
    ${CC} ${S}/test-app.c -o ${S}/test-app --static
    cp ${S}/test-app ${B}/test-app
    ${CC} ${WORKDIR}/test-app_es0_mhu0.c -o ${S}/test-app_es0_mhu0 --static
    ${CC} ${WORKDIR}/test-app_es0_mhu1.c -o ${S}/test-app_es0_mhu1 --static
    ${CC} ${WORKDIR}/pthread_mhu0_inloop.c -o ${S}/pthread_mhu0_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_mhu1_inloop.c -o ${S}/pthread_mhu1_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_se_mhu0_inloop.c -o ${S}/pthread_se_mhu0_inloop -lpthread --static
    ${CC} ${WORKDIR}/pthread_se_mhu1_inloop.c -o ${S}/pthread_se_mhu1_inloop -lpthread --static
    cp ${S}/{test-app_es0_mhu0,test-app_es0_mhu1,pthread_mhu0_inloop,pthread_mhu1_inloop,pthread_se_mhu0_inloop,pthread_se_mhu1_inloop} ${B}
}

do_install() {
    install -d ${D}/${bindir}/
    install -m 0755 ${B}/test-app ${D}${bindir}/test-app
    install -m 0755 ${B}/test-app_es0_mhu0 ${D}${bindir}/test-app_es0_mhu0
    install -m 0755 ${B}/test-app_es0_mhu1 ${D}${bindir}/test-app_es0_mhu1
    install -m 0755 ${B}/pthread_mhu0_inloop ${D}${bindir}/pthread_mhu0_inloop
    install -m 0755 ${B}/pthread_mhu1_inloop ${D}${bindir}/pthread_mhu1_inloop
    install -m 0755 ${B}/pthread_se_mhu0_inloop ${D}${bindir}/pthread_se_mhu0_inloop
    install -m 0755 ${B}/pthread_se_mhu1_inloop ${D}${bindir}/pthread_se_mhu1_inloop
}

COMPATIBLE_MACHINE = "(bolt-fpga)"
