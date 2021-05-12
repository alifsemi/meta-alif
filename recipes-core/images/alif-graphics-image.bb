SUMMARY = "Alif Tiny Image with graphics support"
DESCRIPTION = "Linux rootfs image with graphics support for the APSS"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL = "packagegroup-core-apss"

do_image[depends] += "trusted-firmware-a:do_deploy"
