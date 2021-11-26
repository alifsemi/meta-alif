def calculate_distro_features_from_dct(d, res):
    import json
    from os import path
    json_file = d.getVar("DCT_JSON_FILE") or ""
    dct_distro_features = ""
    if path.exists(json_file):
        json_file_object = open(json_file, "r")
        json_dict = json.load(json_file_object)
        try:
            mst_proc = json_dict["devices"]["device"]["resources"]["masters"]["processors"]
            xip_load_addr = ""
            for mst_proc_idx in range(len(mst_proc)):
                if mst_proc[mst_proc_idx]["id"] == "A32":
                    if mst_proc[mst_proc_idx]["configurables"]["bootAddress"][0]:
                       xip_load_addr = mst_proc[mst_proc_idx]["configurables"]["bootAddress"][0]
                    elif mst_proc[mst_proc_idx]["bootAddressDefault"]:
                       xip_load_addr  = mst_proc[mst_proc_idx]["bootAddressDefault"]
            if res == "masters":
                json_file_object.close()
                return xip_load_addr
            slv_ph = json_dict["devices"]["device"]["resources"]["slaves"]["peripherals"]
            for slv_ph_idx in range(len(slv_ph)):
                for iter in range(len(slv_ph[slv_ph_idx]["modules"])):
                    id = slv_ph[slv_ph_idx]["modules"][iter]["id"]
                    if id == "Power":
                        pass
                    if id == "HWSEM":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-hwsem "

                    if id == "ETH":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                             for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-ethernet "

                    if id == "SPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-spi "
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-spi"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-spi"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-spi"

                    if id == "UART":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-uart"

                    if id == "USB":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-usb"

                    if id == "UTIMER":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if  slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"
                                if  slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-utimer"

                    if id == "SDMMC":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-sd-boot apss-sd-share"

                    if id == "DSI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-dsi"

                    if id == "DPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-dpi"

                    if id == "CSI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-csi"

                    if id == "CPI":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-cpi"

                    if id == "ADC12":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if inst_id == "ADC120" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-adc"
                                if inst_id == "ADC121" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-adc"
                                if inst_id == "ADC122" and slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-adc"

                    if id == "CMP":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-cmp"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-cmp"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-cmp"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-cmp"

                    if id == "DAC12":
                        for inst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"])):
                            for cnf_mst_iter in range(len(slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"])):
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-dac"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-dac"
                                if slv_ph[slv_ph_idx]["modules"][iter]["instances"][inst_iter]["configurables"]["masters"][cnf_mst_iter]["id"] == "A32":
                                    dct_distro_features += " apss-dac"
        except KeyError:
            bb.error("The specified %s DCT JSON file does not contain valid key value. Please set DCT_JSON_FILE with correct JSON file" % ker_json_file)
        json_file_object.close()
    return " ".join(set(dct_distro_features.split()))

DISTRO_FEATURES_append := " ${@calculate_distro_features_from_dct(d, res='slaves')}"
XIP_KERNEL_LOAD_ADDR ?= "${@ '%s' %calculate_distro_features_from_dct(d, res='masters') if calculate_distro_features_from_dct(d, res='masters') else '0x80000000'}"
