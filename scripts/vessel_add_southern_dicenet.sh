#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=southern



script=vessel_add.sh
mesh=dicenet_$region.mesh.json
config=SDA.config.json

bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$mesh $pipeline_directory/configs/vessel_configs/$config
