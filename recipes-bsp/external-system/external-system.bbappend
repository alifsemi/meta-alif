PR .= ".2"

FREERTOS ?= "1"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append += "${@bb.utils.contains('FREERTOS', '1', 'file://0001-Changes-to-compile-framework-with-FreeRTOS.patch', '', d)}"
SRCREV = "CORSTONE-700-2020.02.10"
