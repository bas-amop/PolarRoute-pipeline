#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=weddel



script=mesh_geojson.sh
vessel=SDA
plain_mesh=amsr_${region}.mesh.json
vessel_mesh=amsr_${region}_${vessel}.vessel.json


# Convert plainmesh and vessel mesh to geojson format
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$plain_mesh $plain_mesh.geojson
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$vessel_mesh $vessel_mesh.geojson
