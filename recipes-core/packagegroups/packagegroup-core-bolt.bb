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
"

RDEPENDS_packagegroup-bolt-base = " \
busybox-udhcpd \
test-app \
"

RDEPENDS_packagegroup-bolt-graphics = " \
packagegroup-bolt-base \
"
