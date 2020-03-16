PR .= ".1"

FREERTOS ?= "1"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append += "${@bb.utils.contains('FREERTOS', '1', 'file://0001-Changes-to-compile-framework-with-FreeRTOS.patch', '', d)}"
SRCREV = "1823b4070df6fb9fd214d75f08e79ba815a95a33"
