#!/bin/bash

set -e

# Get absolute path of pipeline, upload and html directories
pipeline_directory=$PIPELINE_DIRECTORY
upload_directory=$PIPELINE_DIRECTORY/upload
html_directory=$PIPELINE_DIRECTORY/html

# Output the standard html header
cat > ${html_directory}/index.html <<'endmsg'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title></title>
    <!-- BAS Style sheet -->
    <link rel="stylesheet" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/css/bas-style-kit.min.css" integrity="sha256-k05vjok9IGTMBJ8KYnQYX9sEc7A9eGWsTM8tQ2XqE8A=" crossorigin="anonymous">
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/favicon-16x16.png" />
    <link rel='manifest' href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/site.webmanifest" />
    <link rel="mask-icon" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/safari-pinned-tab.svg" color="#222222" />
    <link rel="shortcut icon" href="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/favicon.ico" />
    <meta name="msapplication-TileColor" content="#222222">
    <meta name="msapplication-config" content="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/favicon/browserconfig.xml">
    <meta name="theme-color" content="#222222">
</head>
<body>
      <!-- BAS Header -->
      <header class="bsk-header bsk-header-default">
        <div class="bsk-header-container-fluid">
            <a href="#">
                <img class="bsk-header-image-64" alt="British Antarctic Survey Logo" src="https://cdn.web.bas.ac.uk/bas-style-kit/0.6.1/img/logos-symbols/bas-logo-inverse-transparent-64.png">
            </a>
        </div>
    </header>
  <div style="padding: 2%">
    <center>
    <h1>Operational PolarRoute Summary Meshes</h1>
    <hr>
endmsg

# Then output the file specific DOM elements
# We can easily work out which PNG files we have put in the html_directory and then
# populate the <div>s below:

# [1] Delete existing PNG files
find $html_directory/ -name "*.png" -exec rm {} \;

# [2a] Generate PNG files for 'SIC' and insert links into html
echo '<h2>(SIC) Sea Ice Concentration</h2>' >> ${html_directory}/index.html
find $upload_directory/ -name '*.geojson.gz' | while read geojson_file;
do
    filename=$(basename $geojson_file)
    gzip -dcf $geojson_file >$html_directory/${filename%".gz"}
    echo '        <div><a href="sic_'${filename%".gz"}'.png">sic_'${filename%".gz"}'.png</a></div>' >> ${html_directory}/index.html
done
find $html_directory/ -name "*.geojson" -exec geojson2png -p {} \;
find $html_directory/ -name "*.png" -execdir basename {} \; | xargs -I{} mv ${html_directory}/{} ${html_directory}/sic_{}

# [2b] Generate PNG files for 'fuel' and insert links into html
echo '<hr>' >> ${html_directory}/index.html
echo '<h2>(fuel) Fuel Usage</h2>' >> ${html_directory}/index.html
find $html_directory/ -name '*.geojson' | while read geojson_file;
do
    filename=$(basename $geojson_file)
    echo '        <div><a href="fuel_'${filename%".gz"}'.png">fuel_'${filename%".gz"}'.png</a></div>' >> ${html_directory}/index.html
done
find $html_directory/ -name "*.geojson" -exec geojson2png -c fuel {} \;
find $html_directory/ -name "amsr_*.png" -execdir basename {} \; | xargs -I{} mv ${html_directory}/{} ${html_directory}/fuel_{}

# [3] Remove the GEOJSON files from the html directory
find $html_directory/ -name "*.geojson" -exec rm {} \;

echo '    </center>' >> ${html_directory}/index.html

# [4] Give summary of recent source data files
echo '<hr>' >> ${html_directory}/index.html
echo '<div>Data Sources' >> ${html_directory}/index.html
echo '<a><pre>'"$(ls -ahl ${pipeline_directory}/datastore/bathymetry/gebco/gebco_global.nc)"'</pre></a>' >> ${html_directory}/index.html
echo '<a><pre>'"$(ls -ahl ${pipeline_directory}/datastore/currents/duacs-nrt/global/ | tail -n 4)"'</pre></a>' >> ${html_directory}/index.html
echo '<a><pre>'"$(ls -ahl ${pipeline_directory}/datastore/sic/amsr2/north/ | tail -n 4)"'</pre></a>' >> ${html_directory}/index.html
echo '<a><pre>'"$(ls -ahl ${pipeline_directory}/datastore/sic/amsr2/south/ | tail -n 4)"'</pre></a>' >> ${html_directory}/index.html
echo '<div>' >> ${html_directory}/index.html


# Output the standard html footer
echo '</body></html>' >> ${html_directory}/index.html
