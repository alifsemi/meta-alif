# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

SUMMARY = "Minimal boot requirements for the APSS"
DESCRIPTION = "The set of packages required to boot the APSS"
PR = "r5"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

PACKAGES = " \
packagegroup-core-apss \
packagegroup-core-apss-base \
packagegroup-core-apss-iot \
packagegroup-core-apss-graphics \
packagegroup-core-apss-pdm"

SUMMARY_${PN} = "Application Processor SubSystem - Base and Core packages"
SUMMARY_${PN}-base = "Application Processor SubSystem - Base packages"
SUMMARY_${PN}-graphics = "Application Processor SubSystem - Base + Graphics packages"
SUMMARY_${PN}-iot = "Application Processor Subsystem - IoT Libraries + Applications"
SUMMARY_${PN}-pdm = "Application Processor Subsystem - PDM Libraries + Applications like ALSA"

RDEPENDS_${PN} = " \
${PN}-base \
${PN}-graphics \
${PN}-iot \
${PN}-pdm \
"
# Let core boot packagegroup does bot contain graphics packages
#${@bb.utils.contains('DISTRO_FEATURES', 'apss-graphics', 'packagegroup-apss-graphics', '', d)} \
#"

RDEPENDS_packagegroup-core-apss-base = " \
packagegroup-core-boot \
busybox-udhcpd \
busybox-udhcpc \
base-passwd \
helloworld \
helloworld-daemon \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-sd-boot', '${SD_PACKAGES}', '', d)} \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-cdc200', '${CDC200_PACKAGES}', '', d)} \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-mhu', '${MHU_WDOG_PACKAGES}', '', d)} \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-hwsem', '${HWSEM_PACKAGES}', '', d)} \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-crc', '${CRC_PACKAGES}', '', d)} \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-pdm', '${PDM_PACKAGES}', '', d)} \
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

CDC200_PACKAGES = " \
	a32-linux-dd-testcases-cdc200 \
	lv-port-linux-frame-buffer \
"

HWSEM_PACKAGES = " \
a32-linux-dd-testcases-hwsem \
"

MHU_WDOG_PACKAGES = " \
a32-linux-dd-testcases-mhu \
a32-linux-dd-testcases-watchdog \
"

AV_PACKAGES = " \
	alsa-utils \
	alsa-lib \
"

CRC_PACKAGES =  " \
a32-linux-dd-testcases-crc \
"

PDM_PACKAGES = " \
alsa-utils-aplay \
"

RDEPENDS_packagegroup-core-apss-graphics = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-graphics', '${GRAPHICS_PACKAGES} ${AV_PACKAGES}', '', d)} \
"

RDEPENDS_packagegroup-core-apss-pdm = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-pdm', '${PDM_PACKAGES}', '', d)} \
"

IOT_PACKAGES = " \
                aws-iot-device-sdk-embedded-c \
                azure-iot-sdk-c \
"
RDEPENDS_packagegroup-core-apss-iot = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-iot', '${IOT_PACKAGES}', '', d)} \
"
