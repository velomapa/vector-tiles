#!/bin/bash

# Data is stored inside a mounted volume
# which is symlinked to home dir:
#
# ln -s /mnt/XXXX/data mbtiles

# -d deattached
docker run --restart unless-stopped \
  -v "$(pwd)/mbtiles":/mbtiles \
  -v "$(pwd)/data":/data \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl:v4.10.3 -p 8080
