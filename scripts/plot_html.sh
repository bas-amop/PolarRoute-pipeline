#!/bin/bash

set -e

# Local pipeline directory
pipeline_directory=$PIPELINE_DIRECTORY

# Extract mesh name from name of input mesh file
mesh_file=$1
mesh_filename=$(basename $mesh_file)
mesh_name=${mesh_filename%".json"}


# Set up output directory
output_directory="${pipeline_directory}/outputs/most_recent/"
output_name="${mesh_name}.html"

# Create the html file
plot_mesh ${pipeline_directory}/outputs/most_recent/${mesh_filename} -o ${output_directory}${output_name}