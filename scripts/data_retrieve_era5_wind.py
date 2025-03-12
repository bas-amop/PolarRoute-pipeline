import os
import subprocess
import requests
from datetime import datetime, timedelta
import cdsapi

# Download task logic:
# 1. Try to download whatever is available right now.
# 2. If a download fails then make it clear that the download failed but carry on with the task.
# 3. If the task fails for any other reason then this should still raise the appropriate errors and halt if needed.
# 4. If any new data is downloaded then this should trigger re-generation of the mesh(es), which is handled by
#    'check_datastore_manifest'.


# Find location of script and run all commands from there
BASE_DIR = os.path.dirname(os.path.realpath(__file__))
os.chdir(BASE_DIR)

# Determine root of pipeline directory
pipeline_directory = os.getenv("PIPELINE_DIRECTORY")


# Initialise API client
c = cdsapi.Client()

# Find latest date with available data
r = requests.get("https://cds.climate.copernicus.eu/api/catalogue/v1/collections/reanalysis-era5-single-levels")
j = r.json()

output_dir = pipeline_directory + "/datastore/wind/era5/daily/"
latest_date_str = j['extent']['temporal']['interval'][0][1][:10]
date_format = "%Y-%m-%d"

latest_date = datetime.strptime(latest_date_str, date_format).date()

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Loop through most recent three days of data and download wind variables
for i in range(3):
    date = latest_date - timedelta(days=i)

    year = str(date.year)
    month = str(date.month)
    day = str(date.day)

    date_str = date.strftime(date_format)
    output_file = output_dir + f"era5_wind_{date_str}.nc"

    # Check for existing file
    if os.path.isfile(output_file):
        print(f"Wind data file for {date_str} already exists: {output_file}")
        continue

    try:
        c.retrieve(
            'reanalysis-era5-single-levels',
            {
                'product_type': 'reanalysis',
                'variable': [
                    '10m_u_component_of_wind', '10m_v_component_of_wind'
                ],
                'year': year,
                'month': month,
                'day': day,
                'time': [
                    '00:00', '01:00', '02:00',
                    '03:00', '04:00', '05:00',
                    '06:00', '07:00', '08:00',
                    '09:00', '10:00', '11:00',
                    '12:00', '13:00', '14:00',
                    '15:00', '16:00', '17:00',
                    '18:00', '19:00', '20:00',
                    '21:00', '22:00', '23:00',
                ],
                'format': 'netcdf',
                'area': [
                    90, -180, -90,
                    180,
                ],
            },
            output_file)
    except Exception as e:
        print(f"Unable to retrieve wind data file for {date_str}: {output_file}")
        print(str(e))
