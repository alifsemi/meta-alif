PR .= ".1"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://link-libexecinfo-library.patch;patchdir=.. \
            file://0002-python_repo.bzl-set-correct-python-version-available.patch \
            file://0003-Skip-unsupported-archotecture-files-from-compiling-f.patch \
            file://0004-Include-cstdint-header-file-for-compilation.patch \
            file://Use-available-Musl-libc-strtoul.patch;apply=no \
            file://0005-Skip-vcvtaq_s32_f32-for-AArch32.patch \
            file://0001-Disable-compiling-unsupported-architecture-files-for.patch \
            file://disable_compiling_unsupported_arch_files_for_cortexa32.patch;apply=no"

DEPENDS += "libexecinfo"

TF_ARGS_EXTRA ?= "--config=elinux_armhf"

bazel_do_configure:append:armv8a () {
    cat >> "${S}/bazelrc" <<-EOF

build --conlyopt=-D__NO_MALLINFO__ --cxxopt=-D__NO_MALLINFO__
build --conlyopt=-mfpu=neon-fp-armv8 --cxxopt=-mfpu=neon-fp-armv8 --linkopt=-mfpu=neon-fp-armv8

EOF
}

do_compile:prepend:armv8a () {
    export CT_NAME=$(echo ${HOST_PREFIX} | rev | cut -c 2- | rev)
    unset CC

    ${BAZEL} build \
        ${CUSTOM_BAZEL_FLAGS} \
        --copt -DTF_LITE_DISABLE_X86_NEON --copt -DMESA_EGL_NO_X11_HEADERS \
        --define tflite_with_xnnpack=false \
        --repo_env=TF_PYTHON_VERSION=3.12 @flatbuffers//src:distribution

    if [ ! -e ${WORKDIR}/bazel/output_base/external/flatbuffers/.done ] ; then
        pushd ${WORKDIR}
        patch -p0 < Use-available-Musl-libc-strtoul.patch
        touch ${WORKDIR}/bazel/output_base/external/flatbuffers/.done
        popd
    fi

}

COMPATIBLE_HOST:armv8a = ""
