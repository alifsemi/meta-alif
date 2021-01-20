SRC_URI_append += "${@bb.utils.contains("DISTRO_FEATURES", "bolt-graphics", "file://graphics.cfg", "" ,d)}"
SRC_URI_append += "${@bb.utils.contains("DISTRO_FEATURES", "bolt-nfs", "file://nfs.cfg", "" ,d)}"


do_compile_prepend () {
    if [ -e "${B}/.config" ]; then
        sed -i "s:^CONFIG_XIP_PHYS_ADDR=.*:CONFIG_XIP_PHYS_ADDR=${XIP_KERNEL_LOAD_ADDR}:g" ${B}/.config
        sed -i "s:^CONFIG_MTD_PHYSMAP_START=.*:CONFIG_MTD_PHYSMAP_START=${KERNEL_MTD_START_ADDR}:g" ${B}/.config
        sed -i "s:^CONFIG_MTD_PHYSMAP_LEN=.*:CONFIG_MTD_PHYSMAP_LEN=${KERNEL_MTD_LEN}:g" ${B}/.config
    fi
}
