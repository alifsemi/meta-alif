# Copyright (C) 2022 Alif Semiconductor - All Rights Reserved.
# Use, distribution and modification of this code is permitted under the
# terms stated in the Alif Semiconductor Software License Agreement
#
# You should have received a copy of the Alif Semiconductor Software
# License Agreement with this file. If not, please write to:
# contact@alifsemi.com, or visit: https://alifsemi.com/license

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
        shutil.copyfile(ker_dts_macro_file, ker_dts_macro_file_org)
        try:
            slv_ph = ker_json_dict["devices"]["device"]["resources"]["slaves"]["peripherals"]
            for slv_ph_idx in range(len(slv_ph)):
                for iter in range(len(slv_ph[slv_ph_idx]["modules"])):
                    id = slv_ph[slv_ph_idx]["modules"][iter]["id"]
                    if id == "Power":
                        pass
                    if id == "HWSEM":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("HWSEM(.*)_STATUS .*", "HWSEM\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
                    if id == "ETH":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                             for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("ETH_STATUS .*","ETH_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                    if id == "SPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "SPI0"  and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("SPI0_STATUS .*","SPI0_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "SPI1"  and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("SPI1_STATUS .*","SPI1_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "SPI2"  and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("SPI2_STATUS .*","SPI2_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "SPI3"  and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("SPI3_STATUS .*","SPI3_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "UART":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "UART0" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART0_STATUS .*","UART0_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART1" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART1_STATUS .*","UART1_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART2" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART2_STATUS .*","UART2_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART3" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART3_STATUS .*","UART3_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART4" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART4_STATUS .*","UART4_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART5" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART5_STATUS .*","UART5_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART6" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART6_STATUS .*","UART6_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UART7" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UART7_STATUS .*","UART7_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "USB":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("HSUSB_STATUS .*","HSUSB_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "UTIMER":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "UTIMER0" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER0_STATUS .*","UTIMER0_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER1" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER1_STATUS .*","UTIMER1_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER2" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER2_STATUS .*","UTIMER2_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER3" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER3_STATUS .*","UTIMER3_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER4" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER4_STATUS .*","UTIMER4_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER5" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER5_STATUS .*","UTIMER5_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER6" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER6_STATUS .*","UTIMER6_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER7" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER7_STATUS .*","UTIMER7_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER8" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER8_STATUS .*","UTIMER8_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER9" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER9_STATUS .*","UTIMER9_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER10" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER10_STATUS .*","UTIMER10_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "UTIMER11" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("UTIMER11_STATUS .*","UTIMER11_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "SDMMC":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("SDHCI_STATUS .*","SDHCI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "DSI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("DSI_STATUS .*","DSI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "DPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("DPI_STATUS .*","DPI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "CSI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CSI_STATUS .*","CSI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "CPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CPI_STATUS .*","CPI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "ADC12":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "ADC120" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("ADC120_STATUS .*","ADC120_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "ADC121" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("ADC121_STATUS .*","ADC122_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "ADC122" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("ADC122_STATUS .*","ADC122_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "CMP":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "CMP0" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CMP0_STATUS .*","CMP0_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "CMP1" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CMP1_STATUS .*","CMP1_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "CMP2" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CMP2_STATUS .*","CMP2_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "CMP3" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("CMP3_STATUS .*","CMP3_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))

                    if id == "DAC12":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            inst_id = slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["id"]
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "DAC120" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("DAC120_STATUS .*","DAC120_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "DAC121" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("DAC121_STATUS .*","DAC121_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
                                if inst_id == "DAC122" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    ker_dts_macro_file_write.write_text(re.sub("DAC122_STATUS .*","DAC122_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
        except KeyError:
            bb.error("The specified %s DCT JSON file does not contain valid key value. Please set DCT_JSON_FILE with correct JSON file" % ker_json_file)
        ker_json_file_object.close()

    if bb.utils.contains('DISTRO_FEATURES', 'apss-hwsem', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("HWSEM(.*)_STATUS .*", "HWSEM\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-ethernet', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("ETH_STATUS .*","ETH_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-spi', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("SPI(.*)_STATUS .*", "SPI\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-uart', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("UART(.*)_STATUS .*", "UART\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-usb', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("HSUSB_STATUS .*", "HSUSB_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-utimer', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("UTIMER(.*)_STATUS .*", "UTIMER\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains_any('DISTRO_FEATURES', ['apss-sd-share', 'apss-sd-boot'], True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("SDHCI_STATUS .*","SDHCI_STATUS \"okay\"",ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-dsi', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("DSI_STATUS .*", "DSI_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-dpi', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("DPI_STATUS .*", "DPI_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-csi', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("CSI_STATUS .*", "CSI_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-cpi', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("CPI_STATUS .*", "CPI_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-adc', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("ADC12(.*)_STATUS .*", "ADC12\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-dac', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("DAC12(.*)_STATUS .*", "DAC12\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-mhu', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("_MHU(.*)_STATUS .*", "_MHU\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    if bb.utils.contains('DISTRO_FEATURES', 'apss-cdc200', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("CDC200(.*)_STATUS .*", "CDC200\\1_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
    # Enable UART 4 for GDB client-server debug over serial for apss-debug DISTRO_FEATURES
    if bb.utils.contains('DISTRO_FEATURES', 'apss-debug', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("UART4_STATUS .*", "UART4_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
}

python do_choose_uart () {
    import re
    from pathlib import Path
    ker_dts_macro_file = d.getVar("S") + d.getVar("DTS_MACRO_FILE") or ""
    ker_dts_macro_file_write = Path(ker_dts_macro_file)
    if bb.utils.contains('A32_UART', '2', True, False, d):
        ker_dts_macro_file_write.write_text(re.sub("UART2_STATUS .*", "UART2_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
        ker_dts_macro_file_write.write_text(re.sub("UART4_STATUS .*", "UART4_STATUS \"disabled\"", ker_dts_macro_file_write.read_text()))
    else:
        ker_dts_macro_file_write.write_text(re.sub("UART4_STATUS .*", "UART4_STATUS \"okay\"", ker_dts_macro_file_write.read_text()))
        ker_dts_macro_file_write.write_text(re.sub("UART2_STATUS .*", "UART2_STATUS \"disabled\"", ker_dts_macro_file_write.read_text()))
}

addtask dct_to_dts after do_configure before do_compile
addtask choose_uart after do_configure before do_compile

def get_dct_json_checksum_file(d):
    dct_json_file = d.getVar("DCT_JSON_FILE") or ""
    return dct_json_file + ":" + str(os.path.exists(dct_json_file))

do_dct_to_dts[file-checksums] = "${@get_dct_json_checksum_file(d)}"
