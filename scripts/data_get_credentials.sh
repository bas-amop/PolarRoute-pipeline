#!/bin/bash

set -e

# Get absolute path of pipeline directory
pipeline_directory=$PIPELINE_DIRECTORY

# Get user's credentials from their home directory

# CopernicusMarine Credentials
echo COPERNICUS_USER='"'$(cat ${HOME}/.copernicusmarine/user)'"' > ${pipeline_directory}/credentials.env
echo export COPERNICUS_USER >> ${pipeline_directory}/credentials.env
echo COPERNICUS_PASSWORD='"'$(cat ${HOME}/.copernicusmarine/password)'"' >> ${pipeline_directory}/credentials.env
echo export COPERNICUS_PASSWORD >> ${pipeline_directory}/credentials.env
