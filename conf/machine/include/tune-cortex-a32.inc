DEFAULTTUNE ?= "cortexa32"


TUNEVALID[cortexa32] = "Enable Cortex-A32 specific processor optimizations"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'cortexa32', ' -mcpu=cortex-a32', '', d)}"

require conf/machine/include/arm/arch-armv8a.inc

# Little Endian base configs
AVAILTUNES += "cortexa32 cortexa32-neon cortexa32hf-neon cortexa32-crypto cortexa32hf-crypto"
ARMPKGARCH_tune-cortexa32             = "cortexa32"
ARMPKGARCH_tune-cortexa32-neon        = "cortexa32"
ARMPKGARCH_tune-cortexa32hf-neon      = "cortexa32"
ARMPKGARCH_tune-cortexa32-crypto      = "cortexa32"
ARMPKGARCH_tune-cortexa32hf-crypto    = "cortexa32"
TUNE_FEATURES_tune-cortexa32          = "armv8a cortexa32 crc"
TUNE_FEATURES_tune-cortexa32-neon     = "armv8a cortexa32 crc neon"
TUNE_FEATURES_tune-cortexa32hf-neon   = "armv8a cortexa32 crc neon callconvention-hard"
TUNE_FEATURES_tune-cortexa32-crypto   = "armv8a cortexa32 crc crypto"
TUNE_FEATURES_tune-cortexa32hf-crypto = "armv8a cortexa32 crc crypto callconvention-hard"
PACKAGE_EXTRA_ARCHS_tune-cortexa32           = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc} cortexa32"
PACKAGE_EXTRA_ARCHS_tune-cortexa32-neon      = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc} cortexa32 cortexa32-neon"
PACKAGE_EXTRA_ARCHS_tune-cortexa32hf-neon    = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc} cortexa32 cortexa32-neon cortexa32hf-neon"
PACKAGE_EXTRA_ARCHS_tune-cortexa32-crypto    = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc-crypto} cortexa32 cortexa32-crypto"
PACKAGE_EXTRA_ARCHS_tune-cortexa32hf-crypto  = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc-crypto} cortexa32 cortexa32-crypto cortexa32hf-crypto"
BASE_LIB_tune-cortexa32               = "lib"
BASE_LIB_tune-cortexa32-neon          = "lib"
BASE_LIB_tune-cortexa32hf-neon        = "lib"
BASE_LIB_tune-cortexa32-crypto        = "lib"
BASE_LIB_tune-cortexa32hf-crypto      = "lib"
