#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=southern



script=mesh_geojson.sh
vessel=SDA
plain_mesh=dicenet_${region}.mesh.json
vessel_mesh=dicenet_${region}_${vessel}.vessel.json


# Convert plainmesh and vessel mesh to geojson format
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$plain_mesh
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$vessel_mesh
