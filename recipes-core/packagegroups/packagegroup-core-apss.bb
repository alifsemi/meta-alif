SUMMARY = "Minimal boot requirements for the APSS"
DESCRIPTION = "The set of packages required to boot the APSS"
PR = "r2"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

PACKAGES = " \
packagegroup-core-apss \
packagegroup-core-apss-base \
packagegroup-core-apss-iot \
packagegroup-core-apss-graphics"

SUMMARY_${PN} = "Application Processor SubSystem - Base and Core packages"
SUMMARY_${PN}-base = "Application Processor SubSystem - Base packages"
SUMMARY_${PN}-graphics = "Application Processor SubSystem - Base + Graphics packages"
SUMMARY_${PN}-iot = "Application Processor Subsystem - IoT Libraries + Applications"

RDEPENDS_${PN} = " \
${PN}-base \
${PN}-graphics \
${PN}-iot \
"
# Let core boot packagegroup does bot contain graphics packages
#${@bb.utils.contains('DISTRO_FEATURES', 'apss-graphics', 'packagegroup-apss-graphics', '', d)} \
#"

RDEPENDS_packagegroup-core-apss-base = " \
packagegroup-core-boot \
busybox-udhcpd \
busybox-udhcpc \
a32-linux-dd-testcases \
base-passwd \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-sd-boot', '${SD_PACKAGES}', '', d)} \
"

SD_PACKAGES = " util-linux-fdisk \
                e2fsprogs-mke2fs \
                dosfstools \
"

GRAPHICS_PACKAGES = " \
	libdrm \
	libdrm-tests \
	devmem2 \
	e2fsprogs-resize2fs \
	rsync \
	haveged \
	smartwatch-demo \
	cdc-mod \
	d2d-mod \
	kmod \
	fbset \
"

AV_PACKAGES = " \
	alsa-utils \
	alsa-lib \
"

RDEPENDS_packagegroup-core-apss-graphics = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-graphics', '${GRAPHICS_PACKAGES} ${AV_PACKAGES}', '', d)} \
"
IOT_PACKAGES = " \
                aws-iot-device-sdk-embedded-c \
                azure-iot-sdk-c \
"
RDEPENDS_packagegroup-core-apss-iot = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-iot', '${IOT_PACKAGES}', '', d)} \
"
