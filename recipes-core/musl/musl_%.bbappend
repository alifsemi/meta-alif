PR .= ".1"

# FIXME: hack to run executable compiled using SDK (toolchain installer)
do_install_append () {
   ln -sf ${GLIBC_LDSO} ${D}/lib/ld-linux.so.3
}
