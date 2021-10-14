SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-graphics", "file://graphics.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-nfs", "file://nfs.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-sd-share", "file://sd.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-sd-boot", "file://sd_boot.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-hwsem", "file://hwsem.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-mhu", "file://mhuv2.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-usb", "file://usb.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-spi", "file://spi.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-ethernet", "file://ethernet.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-usb-host", "file://usb_host.cfg", "" ,d)}"
SRC_URI_append += " ${@bb.utils.contains("DISTRO_FEATURES", "apss-cdc200", "file://cdc200.cfg", "" ,d)}"

PR .= ".9"
inherit dct-kernel

KERNEL_CC_append = " -DA32_HWSEM_MST_ID=${A32_HWSEM_MST_ID} "

do_compile_prepend () {
    if [ -e "${B}/.config" ]; then
        sed -i "s:^CONFIG_XIP_PHYS_ADDR=.*:CONFIG_XIP_PHYS_ADDR=${XIP_KERNEL_LOAD_ADDR}:g" ${B}/.config
        sed -i "s:^CONFIG_MTD_PHYSMAP_START=.*:CONFIG_MTD_PHYSMAP_START=${KERNEL_MTD_START_ADDR}:g" ${B}/.config
        sed -i "s:^CONFIG_MTD_PHYSMAP_LEN=.*:CONFIG_MTD_PHYSMAP_LEN=${KERNEL_MTD_LEN}:g" ${B}/.config
        sed -i "s:^CONFIG_PHYS_OFFSET=.*:CONFIG_PHYS_OFFSET=${TRUSTED_SRAM0}:g" ${B}/.config
    fi
}
