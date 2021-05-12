SUMMARY = "Minimal boot requirements for the APSS"
DESCRIPTION = "The set of packages required to boot the APSS"
PR = "r0"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

PACKAGES = " \
packagegroup-core-apss \
packagegroup-core-apss-base \
packagegroup-core-apss-graphics"

SUMMARY_${PN} = "Application Processor SubSystem - Base and Core packages"
SUMMARY_${PN}-base = "Application Processor SubSystem - Base packages"
SUMMARY_${PN}-graphics = "Application Processor SubSystem - Base + Graphics packages"

RDEPENDS_${PN} = " \
${PN}-base \
${PN}-graphics \
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
${@bb.utils.contains('DISTRO_FEATURES', 'apss-sd', '${SD_PACKAGES}', '', d)} \
"

SD_PACKAGES = " util-linux-fdisk \
		e2fsprogs-mke2fs \
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

RDEPENDS_packagegroup-core-apss-graphics = " \
${@bb.utils.contains('DISTRO_FEATURES', 'apss-graphics', '${GRAPHICS_PACKAGES}', '', d)} \
"
