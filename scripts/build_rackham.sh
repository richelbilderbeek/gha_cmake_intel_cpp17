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

# Load the old Intel compiler
# module load intel/20.4
# Load the newer Intel compiler
module load bioinfo-tools wrf-python/1.3.1 ABINIT/8.10.3 Amber/20 CDO/1.9.5 GOTM/5.3-221-gac7ec88d MUMPS/5.5.0 CDO/1.9.5 PRISMS-PF/2.1.1 PROJ/8.1.0 Siesta/4.1-b4 Singular/4.1.2 deal.II/9.1.1-intel intel/2022a

module load cmake/3.22.2 

# Create the folder, even if it already exists
mkdir build
cd build
rm -f CMakeCache.txt
cmake ..
cmake --build . --config=Release --target all -j 10
cd ..

