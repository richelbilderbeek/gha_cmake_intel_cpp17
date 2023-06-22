#!/bin/bash
#
# Build this project.
#
# Usage:
#
#   ./scripts/build.sh
#
#
if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster, great!"
else
  echo "Not working on a cluster, sourcing a file"
  source /opt/intel/oneapi/setvars.sh
fi

cmake -S . -B build
cmake --build build

