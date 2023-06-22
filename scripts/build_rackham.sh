#!/bin/bash
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 10:00
#SBATCH --job-name gha_intel_cpp17
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
#  Or using the convenience script:
#
#   ./sbatch_richel.sh
#
if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster"
else
  echo "Not working on a cluster, stopping"
  exit 42
fi

date

# 'intel-oneapi' is a complex module:
# after loading it, one adds modules from it, 
# e.g. loading the compiler with: 'module load intel-oneapi compiler'
# Use 'll /sw/comp/intel/oneapi/modulefiles' to see those secondary modules.
module load gcc/13.1.0 cmake/3.22.2 intel-oneapi compiler

# Let's see what this does
cmake -S . -B build

#
#cmake -S . \
#  -B build \
#  -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
#  -DCMAKE_INSTALL_PREFIX=install \
#  -DTBB_ROOT="/sw/comp/intel/oneapi/tbb/latest"


#  -DMKL_ROOT="/sw/comp/intel/oneapi/mkl/latest" \ # Move these to CMakeLists.txt
#  -DCMAKE_CXX_COMPILER=icpc \ # Move these to CMakeLists.txt
#  -DCMAKE_C_COMPILER=icc \ # Move these to CMakeLists.txt


# This folder does exists:
#  -DIntelDPCPP_DIR="/sw/comp/intel/oneapi/compiler/2021.4.0/linux/cmake/SYCL" \

# oneapi/compiler/2021.4.0/linux/cmake
# 

# Is an actual folder
#   -DIntelDPCPP_DIR="/sw/comp/intel/oneapi/compiler/latest/linux/IntelSYCL" \

# Does not exists
#  -DIntelDPCPP_DIR="/sw/comp/intel/oneapi/compiler/latest/linux/cmake/SYCL" \

cmake --build build

./build/gha_cmake_intel_cpp17

