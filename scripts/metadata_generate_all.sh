#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Regions
json_regions=("northern" "central" "southern")
geojson_regions=("northern" "centralnorth" "centralsouth" "southern")


script=metadata_generate.py
vessel=SDA
options="-dmisl"
all_files_list=""


# For json regions add files
for region in "${json_regions[@]}"
do
    all_files_list=${all_files_list}" ${pipeline_directory}/outputs/most_recent/amsr_${region}_${vessel}.vessel.json"
done

# For geojson regions add files
for region in "${geojson_regions[@]}"
do
    all_files_list=${all_files_list}" ${pipeline_directory}/outputs/most_recent/amsr_${region}_${vessel}.vessel.geojson"
done


python $scripts_directory/$script $options $all_files_list
