#!/bin/bash
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 10:00
#SBATCH --job-name gha_cmake_intel_cpp17
#SBATCH --output build_rackham.log
#SBATCH --qos=short
#
# Build the project on Rackham, an UPPMAX computer cluster, see
# https://www.uppmax.uu.se/support/user-guides/rackham-user-guide/
#
# Usage:
#
#   ./scripts/build_rackham.sh
#
#  Using sbatch, when being Richel:
#
#   sbatch -A uppmax2023-2-25 -M snowy scripts/build_rackham.sh
#
if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster"
else
  echo "Not working on a cluster, stopping"
  exit 42
fi

module load intel/20.4
module load cmake/3.22.2 

echo "Where is the icpc compiler?"
which icpc

# [richel@rackham1 bin]$ pwd
# /sw/comp/intel/compilers_and_libraries_2020.4.304/linux/bin
# [richel@rackham1 bin]$ ./icpx --version
# Intel(R) oneAPI DPC++ Compiler 2021.1 (2020.8.0.0827)
# Target: x86_64-unknown-linux-gnu
# Thread model: posix
# InstalledDir: /sw/comp/intel/compilers_and_libraries_2020.4.304/linux/bin

echo "Where is the icpx compiler?"
which icpx

cmake -S . -B build \
           -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
           -DCMAKE_INSTALL_PREFIX=install \
           -DCMAKE_CXX_COMPILER=icpc \
           -DCMAKE_C_COMPILER=icc \
           -DIntelDPCPP_DIR="/opt/intel/oneapi/compiler/latest/linux/cmake/SYCL" \
           -DMKL_ROOT="/opt/intel/oneapi/mkl/latest" \
           -DTBB_ROOT="/opt/intel/oneapi/tbb/latest"

# Cannot find this on Rackham, not in /sw/comp/intel/compilers_and_libraries_2020.4.304/linux
# source /opt/intel/oneapi/setvars.sh

cmake --build build
./build/gha_cmake_intel_cpp17

# Create the folder, even if it already exists
#mkdir build
#cd build
#rm -f CMakeCache.txt
#cmake ..
#cmake --build . --config=Release --target all -j 10
#cd ..

