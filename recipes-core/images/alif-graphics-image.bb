# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

SUMMARY = "Alif Tiny Image with graphics support"
DESCRIPTION = "Linux rootfs image with graphics support for the APSS"
LICENSE = "MIT"

inherit core-image

PR = "r1"

IMAGE_INSTALL = "packagegroup-core-apss"

do_image[depends] += "trusted-firmware-a:do_deploy"
