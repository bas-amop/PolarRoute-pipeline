#!/bin/bash

set -e

# Get absolute path of pipeline, most_recent and scripts directories
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY
most_recent_directory=$PIPELINE_DIRECTORY/outputs/most_recent

# Allow time for previous files written to disk
sleep 5

# Detect all of the .json.gz and .geojson.gz files in the most_recent directory
# and determine their plain region names.
region_files=($(ls $most_recent_directory/*.{geojson.gz,json.gz}))
geojson_regions=()
json_regions=()
for region in "${region_files[@]}"
do
    end_trim=${region#${most_recent_directory}/amsr_}
    region_vessel=$(echo ${end_trim} | cut -d. -f1)
    plain_region=${region_vessel%_SDA*}
    if [ ${region##*geojson.} = 'gz' ] ; then
        # SPECIAL CASE - Dont prepare central geojson upload
        if [ ${plain_region} != 'central' ] ; then
            geojson_regions+=(${plain_region})
        fi
    else
        json_regions+=(${plain_region})
    fi
done

# Make the plain region lists contain only unique regions
geojson_regions=($(for reg in "${geojson_regions[@]}"; do echo "${reg}"; done | sort -u))
json_regions=($(for reg in "${json_regions[@]}"; do echo "${reg}"; done | sort -u))

echo "geojson: ${geojson_regions[@]}"
echo "json   : ${json_regions[@]}"

script=upload_prepare.sh
vessel=SDA
all_files_list="upload_metadata.yaml.gz"


# For geojson regions add files
for region in "${geojson_regions[@]}"
do
    all_files_list=${all_files_list}" amsr_${region}_${vessel}.vessel.geojson.gz"
done

# For json regions add files
for region in "${json_regions[@]}"
do
    all_files_list=${all_files_list}" amsr_${region}_${vessel}.vessel.json.gz"
done


bash $scripts_directory/$script $all_files_list
