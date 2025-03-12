#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY


# Define all the High Resolution Regions
prepend="hires-"
highres_regions=("falk-roth" "roth-roth" "roth-engc" "engc-engc" "cust-cust")


script=mesh_geojson.sh
vessel=SDA

# For all high res regions convert vessel meshes to geojson format
for region in "${highres_regions[@]}"
do
    bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/amsr_${prepend}${region}_${vessel}.vessel.json
done

