SUMMARY = "Minimal boot requirements for Bolt System"
DESCRIPTION = "The set of packages required to boot the Bolt system"
PR = "r0"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PACKAGES = "${PN} \
            packagegroup-bolt-base \
            packagegroup-bolt-graphics"

SUMMARY_${PN} = "Bolt system - Base and Core packages"
SUMMARY_packagegroup-bolt-base = "Bolt system - Base packages"
SUMMARY_packagegroup-bolt-graphics = "Bolt system - Base + Graphics packages"

RDEPENDS_${PN} = " \
packagegroup-bolt-base \
packagegroup-bolt-graphics \
"

RDEPENDS_packagegroup-bolt-base = " \
packagegroup-core-boot \
busybox-udhcpd \
busybox-udhcpc \
test-app \
base-passwd \
"

RDEPENDS_packagegroup-bolt-graphics = " \
	libdrm \
	libdrm-tests \
	devmem2 \
	e2fsprogs-resize2fs \
	rsync \
	haveged \
	smartwatch-demo \
	cdc-mod \
	d2d-mod \
"

MACHINE_EXTRA_RDEPENDS += "kernel-module-cdc kernel-module-d2d"
