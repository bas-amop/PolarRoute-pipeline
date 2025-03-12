#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY


# Define all the High Resolution Regions
prepend="hires-"
highres_regions=("falk-roth" "roth-roth" "roth-engc" "engc-engc" "cust-cust")


script=vessel_add.sh
config=SDA.config.json

echo "Started adding vessel characteristics to high-res meshes"

# For all high res regions add the vessel characteristics
for region in "${highres_regions[@]}"
do
    bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/amsr_${prepend}${region}.mesh.json $pipeline_directory/configs/vessel_configs/$config &
done

wait

echo "Finished adding vessel characteristics to high-res meshes"
