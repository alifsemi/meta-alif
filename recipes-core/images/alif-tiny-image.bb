SUMMARY = "Alif Tiny Minimal Image"
DESCRIPTION = "Tiny Linux image for the APSS"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL = "packagegroup-core-apss"

do_image[depends] += "trusted-firmware-a:do_deploy"
