#!/bin/bash

set -e

# Get absolute path of the scripts directory
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Regions
json_regions=("northern" "central" "southern")
geojson_regions=("northern" "centralnorth" "centralsouth" "southern")


script=upload_prepare.sh
vessel=SDA
all_files_list="upload_metadata.yaml.gz"


# For json regions add files
for region in "${json_regions[@]}"
do
    all_files_list=${all_files_list}" amsr_${region}_${vessel}.vessel.json.gz"
done

# For geojson regions add files
for region in "${geojson_regions[@]}"
do
    all_files_list=${all_files_list}" amsr_${region}_${vessel}.vessel.geojson.gz"
done


bash $scripts_directory/$script $all_files_list
