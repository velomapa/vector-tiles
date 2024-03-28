#!/bin/bash

# Data is stored inside a mounted volume
# which is symlinked to the data/output.mbtiles
#
# ln -s /mnt/XXXX/data/name.mbtiles data/output.mbtiles
#
# To list drives:
# lsblk

# -d deattached
docker run -d --restart unless-stopped \
  -v "$(pwd)/data":/data \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl:v4.10.3 -p 8080
