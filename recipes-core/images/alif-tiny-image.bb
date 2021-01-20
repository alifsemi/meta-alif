SUMMARY = "Alif Tiny Minimal Image"
DESCRIPTION = "Tiny Linux image for Bolt Distribution"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL = "packagegroup-core-bolt"

do_image[depends] += "trusted-firmware-a:do_deploy"
