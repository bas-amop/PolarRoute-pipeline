#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY


# Define all the High Resolution Regions
prepend="hires-"
highres_regions=("falk-roth" "roth-roth" "roth-engc" "engc-engc" "cust-cust")


script=mesh_generate.sh

echo "Started generating high-res meshes"

# For all high res regions calculate the mesh
for region in "${highres_regions[@]}"
do
    bash $scripts_directory/$script $pipeline_directory/configs/environment_configs/amsr_${prepend}${region}.config.json &
done

wait

echo "Finished generating high-res meshes"
