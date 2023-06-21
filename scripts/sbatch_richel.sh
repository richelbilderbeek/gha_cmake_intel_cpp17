#!/bin/bash
#
# sbatch the script as Richel
#
# Usage:
#
#   ./sbatch_richel.sh
#
# No need to sbatch this script.
#

if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster"
else
  echo "Not working on a cluster, stopping"
  exit 42
fi

sbatch -A uppmax2023-2-25 -M snowy scripts/build_rackham.sh