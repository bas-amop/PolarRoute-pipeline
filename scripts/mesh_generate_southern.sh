#!/bin/bash

set -e

# Get absolute path of pipeline directory and scripts directory
pipeline_directory=$PIPELINE_DIRECTORY
scripts_directory=$SCRIPTS_DIRECTORY

bash $scripts_directory/mesh_generate.sh $pipeline_directory/configs/environment_configs/amsr_southern.config.json
