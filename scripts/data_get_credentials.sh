#!/bin/bash

set -e

copernicus_credentials_dir="$HOME/.copernicusmarine"
copernicus_credentials_file="$copernicus_credentials_dir/.copernicusmarine-credentials"

# CopernicusMarine Credentials
if [ -f "$copernicus_credentials_file" ]; then
    echo "Using copernicusmarine credentials from $copernicus_credentials_file"
elif [ -f "$copernicus_credentials_dir/user" ] && [ -f "$copernicus_credentials_dir/password" ]; then
    COPERNICUS_USER=$(< "${HOME}"/.copernicusmarine/user)
    COPERNICUS_PASSWORD=$(< "${HOME}"/.copernicusmarine/password)

    copernicusmarine login \
    --username "$COPERNICUS_USER" \
    --password "$COPERNICUS_PASSWORD"

else
    echo "ERROR - No credentials found for copernicusmarine. Please log in using copernicusmarine login"
    exit 1
fi

