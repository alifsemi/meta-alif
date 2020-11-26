SRC_URI_append += "${@bb.utils.contains("DISTRO_FEATURES", "bolt-graphics", "file://graphics.cfg", "" ,d)}"
