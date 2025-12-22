#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=weddel



script=plot_html.sh
vessel=SDA
mesh=amsr_${region}_${vessel}_fuel.route.json


# Plot the mesh to html file
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$mesh
