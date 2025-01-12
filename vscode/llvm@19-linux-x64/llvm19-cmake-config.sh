#!/bin/bash
set -eu

# Building LLVM with CMake
# https://releases.llvm.org/19.1.0/docs/CMake.html
#
# how to build:
# ./run-cmake.sh
# ninja -C llvm-project/build -j10
# sudo ninja -C llvm-project/build install

script_dir="$(dirname "$(realpath -f "$0")")"
build_dir="${script_dir}/llvm-project/build"
mkdir -p $build_dir
cd $build_dir

cmake_opts=(
  -G Ninja
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=/opt/llvm/llvm@19
  -DLLVM_CCACHE_BUILD=ON
  -DLLVM_ENABLE_PROJECTS="clang;lld"
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind"
  -DLLVM_TARGETS_TO_BUILD="AArch64;RISCV;X86"
  -DLLVM_USE_LINKER=mold
)

export CCACHE_BASEDIR="${script_dir}/llvm-project"
cmake ../llvm "${cmake_opts[@]}"
