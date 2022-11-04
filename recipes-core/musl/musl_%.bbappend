# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

PR .= ".2"

# FIXME: hack to run executable compiled using SDK (toolchain installer)
do_install_append () {
   ln -sf ${GLIBC_LDSO} ${D}/lib/ld-linux.so.3
}
