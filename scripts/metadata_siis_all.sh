#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Regions
geojson_regions=("northern" "centralnorth" "centralsouth" "southern")


script=metadata_siis.py
vessel=SDA
all_files_list=""


# For geojson regions add files
for region in "${geojson_regions[@]}"
do
    for found in $(find ${pipeline_directory}/upload/ -iname amsr_${region}_${vessel}.vessel_???????????????.geojson.gz ); 
    do
        all_files_list=${all_files_list}" ${found}"
    done
done

python $scripts_directory/$script $all_files_list
