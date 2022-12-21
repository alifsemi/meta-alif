python aes_enc_kernel () {
    if d.getVar("ENABLE_AES") == "1":
        for imagetype in d.getVar("KERNEL_IMAGETYPES").split():
            if imagetype in ['xipImage']:
                import os, CSPI_AES128_ECB
                image_loc = d.getVar("B") + "/" + d.getVar("KERNEL_OUTPUT_DIR")
                in_file = image_loc + "/" + "".join(imagetype)
                out_file = image_loc + "/" + "".join(imagetype) + ".enc"
                aes_key = d.getVar("AES_ENC_KEY")
                check = CSPI_AES128_ECB.encrypt_data(in_file, out_file, aes_key, 1)
                if check != 0:
                    bb.fatal("AES encryption for %s with AES key %s FAILED!!!!" %(in_file, aes_key))
                else:
                    bb.note("AES encryption for %s with AES key %s SUCCEEDED!!!!" %(in_file, aes_key))
                    os.rename(in_file, in_file + ".orig")
                    os.rename(out_file, in_file)
}


python aes_enc_rootfs() {
    if d.getVar("ENABLE_AES") == "1":
        for imagefstype in d.getVar("IMAGE_FSTYPES").split():
            if imagefstype in ['cramfs-xip']:
                import os, CSPI_AES128_ECB
                rfs_name = d.getVar("IMGDEPLOYDIR")+ "/" + d.getVar("IMAGE_NAME") + d.getVar("IMAGE_NAME_SUFFIX")
                in_file = rfs_name + "." + "".join(imagefstype)
                out_file = rfs_name + "." + "".join(imagefstype) + ".enc"
                aes_key = d.getVar("AES_ENC_KEY")
                check = CSPI_AES128_ECB.encrypt_data(in_file, out_file, aes_key, 1)
                if check != 0:
                    bb.fatal("AES encryption for %s with AES key %s FAILED!!!!" %(in_file, aes_key))
                else:
                    bb.note("AES encryption for %s with AES key %s SUCCEEDED!!!!" %(in_file, aes_key))
                    os.rename(in_file, in_file + ".orig")
                    os.rename(out_file, in_file)
}
