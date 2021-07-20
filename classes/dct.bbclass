def calculate_distro_features_from_dct(d):
    import json
    from os import path
    json_file = d.getVar("DCT_JSON_FILE") or ""
    dct_distro_features = ""
    if json_file:
        if path.exists(json_file):
            json_file_object = open(json_file, "r")
            json_dict = json.load(json_file_object)
            try:
                for iter in json_dict["devices"]["device"]["resources"]["masters"]["peripherals"]:
                    if iter["id"] == "USB(1MB)":
                        dct_distro_features += " apss-usb "
                    if iter["id"] == "ETH":
                        dct_distro_features += " apss-ethernet "
                    if iter["id"] == "SDMMC":
                        dct_distro_features += " apss-sd-boot "
            except KeyError:
                bb.error("The specified %s DCT JSON file does not contain valid key value. Please set DCT_JSON_FILE with correct JSON file" % json_file)
            json_file_object.close()
    return dct_distro_features


DISTRO_FEATURES_append := "${@calculate_distro_features_from_dct(d)}"
