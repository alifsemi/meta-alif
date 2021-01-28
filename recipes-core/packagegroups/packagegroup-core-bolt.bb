SUMMARY = "Minimal boot requirements for Bolt System"
DESCRIPTION = "The set of packages required to boot the Bolt system"
PR = "r0"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

PACKAGES = " \
packagegroup-core-bolt \
packagegroup-core-bolt-base \
packagegroup-core-bolt-graphics"

SUMMARY_${PN} = "Bolt system - Base and Core packages"
SUMMARY_${PN}-base = "Bolt system - Base packages"
SUMMARY_${PN}-graphics = "Bolt system - Base + Graphics packages"

RDEPENDS_${PN} = " \
${PN}-base \
${PN}-graphics \
"
# Let core boot packagegroup does bot contain graphics packages
#${@bb.utils.contains('DISTRO_FEATURES', 'bolt-graphics', 'packagegroup-bolt-graphics', '', d)} \
#"

RDEPENDS_packagegroup-core-bolt-base = " \
packagegroup-core-boot \
busybox-udhcpd \
busybox-udhcpc \
a32-linux-dd-testcases \
base-passwd \
${@bb.utils.contains('DISTRO_FEATURES', 'bolt-sd', '${SD_PACKAGES}', '', d)} \
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

RDEPENDS_packagegroup-core-bolt-graphics = " \
${@bb.utils.contains('DISTRO_FEATURES', 'bolt-graphics', '${GRAPHICS_PACKAGES}', '', d)} \
"
