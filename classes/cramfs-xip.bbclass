SUMMARY = "Cramfs XIP image type"
DESCRIPTION = "Cramfs XIP type image to add to IMAGE_TYPES"
LICENSE = "MIT"

inherit image_types

do_image_cramfs_xip[depends] += "cramfs-tools-native:do_populate_sysroot bc-native:do_populate_sysroot"

IMAGE_TYPES += " cramfs-xip"

IMAGE_CMD_cramfs-xip () {
    mkcramfs -n ${IMAGE_NAME} -X ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.cramfs-xip ${EXTRA_IMAGECMD}
    mtd_size="$(echo "ibase=16;$(echo "${KERNEL_MTD_LEN}"| sed "s:0[x,X]::")"| bc -l)"
    rootfs_size="$(ls -lb ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.cramfs-xip | cut -d " " -f5)"

    if [ $mtd_size -lt $rootfs_size ] ; then
        bbwarn "The MTD partition size is less than ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.cramfs-xip size. Set KERNEL_MTD_LEN with value morethan ${KERNEL_MTD_LEN} in conf/local.conf to mount cramfs-xip successfully."
    fi
}
