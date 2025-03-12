#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=central



script=mesh_geojson_split.py
vessel=SDA
#plain_mesh=amsr_${region}.mesh.geojson
vessel_mesh=amsr_${region}_${vessel}.vessel.geojson


# Convert plainmesh and vessel mesh to geojson format
#python $scripts_directory/$script --latitude 0.0 $pipeline_directory/outputs/most_recent/$plain_mesh
python $scripts_directory/$script --latitude 0.0 $pipeline_directory/outputs/most_recent/$vessel_mesh
