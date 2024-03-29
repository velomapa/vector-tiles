#!/bin/bash

# Requires Docker
# I'm executing it in Hetzner cloud VPS
# CPX51 16 VCPU; 32 GB RAM; 360 GB SSD
# due to Hetzner limits for new accounts I couldn't get bigger machine :)

# sudo apt update -y

mkdir ~/mbtiles >/dev/null 2>&1

docker run -e \
  JAVA_TOOL_OPTIONS="-Xms20g -Xmx20g -XX:OnOutOfMemoryError=\"kill -9 %p\"" \
  -v "$(pwd)/mbtiles":/data \
  openmaptiles/planetiler-openmaptiles:3.14.0 \
  --area=europe \
  --bounds=planet \
  --download  \
  --nodemap-type=sortedtable \
  --nodemap-storage=mmap \
  --force 2>&1 | tee logs.txt &

mv ~/mbtiles/output.mbtiles ~/data/output.mbtiles
