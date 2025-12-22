#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=weddel



script=routes_calculate.sh
mesh=amsr_${region}_SDA.vessel.json
config=fuel.config.json
waypoints=waypoints.csv

bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$mesh $pipeline_directory/configs/route_configs/$config $pipeline_directory/outputs/most_recent/$waypoints
