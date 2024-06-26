# Copyright (C) 2023 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

python __anonymous () {
    if d.getVar("AES_EN") == "1":
        if bb.data.inherits_class('image', d) or bb.data.inherits_class('kernel', d):
            depends = d.getVar("DEPENDS")
            d.setVar("DEPENDS", depends + " python3-pycryptodome-native ")
            inherits = d.getVar("INHERIT")
            d.setVar("INHERIT", inherits + " python3native")
}

aes_enc_rootfs() {
 if [ "${AES_EN}" = "1" ] ; then
    for iter in ${IMAGE_FSTYPES} ; do
        if [ "$iter" = "cramfs-xip" ] ; then
            ${STAGING_BINDIR_NATIVE}/python3-native/python3 ${ALIFBASE}/lib/CSPI_AES128_ECB.py -i ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter -o ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter.enc -k ${AES_ENC_KEY} -d 1
            mv ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter.orig
            mv ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter.enc ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$iter
        fi
    done
 fi
}
