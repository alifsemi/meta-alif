DTS_MACRO_FILE ?= "/arch/arm/boot/dts/devkit_ex_dct_defines.h"
DTS_MACRO_FILE_ORG ?= "/arch/arm/boot/dts/devkit_ex_dct_defines.h.org"

python do_dct_to_dts () {
    import json, re, shutil
    from os import path
    from pathlib import Path
    ker_dts_macro_file = d.getVar("S") + d.getVar("DTS_MACRO_FILE") or ""
    ker_dts_macro_file_org = d.getVar("S") + d.getVar("DTS_MACRO_FILE_ORG") or ""
    ker_json_file = d.getVar("DCT_JSON_FILE") or ""
    ker_dts_macro_file_write = Path(ker_dts_macro_file)
    if path.exists(ker_json_file):
        ker_json_file_object = open(ker_json_file, "r")
        ker_json_dict = json.load(ker_json_file_object)
        try:
            for iter in ker_json_dict["devices"]["device"]["resources"]["masters"]["peripherals"]:
                shutil.copyfile(ker_dts_macro_file, ker_dts_macro_file_org)
                if iter["id"] == "USB(1MB)":
                    pass
                if iter["id"] == "ETH":
                    ker_dts_macro_file_write.write_text(re.sub("ETH_STATUS .*","ETH_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                if iter["id"] == "SDMMC":
                    ker_dts_macro_file_write.write_text(re.sub("SDHCI_STATUS .*","SDHCI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
        except KeyError:
            bb.error("The specified %s DCT JSON file does not contain valid key value. Please set DCT_JSON_FILE with correct JSON file" % ker_json_file)
        ker_json_file_object.close()
    if bb.utils.contains('DISTRO_FEATURES', 'apss-ethernet', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("ETH_STATUS .*","ETH_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
    if bb.utils.contains_any('DISTRO_FEATURES', ['apss-sd-share', 'apss-sd-boot'], True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("SDHCI_STATUS .*","SDHCI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-mhu', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("_MHU(.*)_STATUS .*", "_MHU\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-hwsem', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("HWSEM(.*)_STATUS .*", "HWSEM\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
}

addtask dct_to_dts after do_configure before do_compile

def get_dct_json_checksum_file(d):
    dct_json_file = d.getVar("DCT_JSON_FILE") or ""
    return dct_json_file + ":" + str(os.path.exists(dct_json_file))

do_dct_to_dts[file-checksums] = "${@get_dct_json_checksum_file(d)}"
