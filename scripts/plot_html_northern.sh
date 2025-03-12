#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

# Define the Region
region=northern



script=plot_html.sh
vessel=SDA
mesh=amsr_${region}_${vessel}.vessel.json


# Plot the mesh to html file
bash $scripts_directory/$script $pipeline_directory/outputs/most_recent/$mesh
