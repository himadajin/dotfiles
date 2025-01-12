#!/bin/bash
set -eu

script_dir="$(dirname "$(realpath "$0")")"
build_dir="${script_dir}/llvm-project/build"
mkdir -p $build_dir
cd $build_dir

cmake_opts=(
  -G Ninja
  -DCMAKE_BUILD_TYPE="Release"
  -DCMAKE_OSX_ARCHITECTURES="arm64"
  -DCMAKE_INSTALL_PREFIX=/opt/llvm/llvm@19
  -DDEFAULT_SYSROOT="$(xcrun --sdk macosx --show-sdk-path)"
  -DLLVM_BUILD_DOCS="ON"
  -DLLVM_CCACHE_BUILD="ON"
  -DLLVM_ENABLE_PROJECTS="clang;lld"
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind"
  -DLLVM_TARGETS_TO_BUILD="AArch64;RISCV;X86"
)

export CCACHE_BASEDIR="${script_dir}/llvm-project"
cmake ../llvm "${cmake_opts[@]}"
