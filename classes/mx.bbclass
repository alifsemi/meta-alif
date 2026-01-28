# Copyright (C) 2026 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

python mx_rev16_rootfs() {
    import os
    if d.getVar("MX_FLASH_EN") == "1":
        imgdeploydir = d.getVar("IMGDEPLOYDIR")
        image_name = d.getVar("IMAGE_NAME")
        image_fstypes = d.getVar("IMAGE_FSTYPES").split()
        for ftype in image_fstypes:
            if ftype == "cramfs-xip":
                src_file = os.path.join(imgdeploydir, "{}.{}".format(image_name, ftype))
                if os.path.exists(src_file):
                    with open(src_file, 'rb') as f:
                        data = f.read()
                    if len(data) % 2 != 0:
                        data += b'\x00'
                    swapped = bytearray()
                    for i in range(0, len(data), 2):
                        swapped.append(data[i+1])
                        swapped.append(data[i])
                    with open(src_file, 'wb') as f:
                        f.write(swapped)
                    bb.note("mx_rev16_rootfs: Byte-swapped {}".format(src_file))
}
