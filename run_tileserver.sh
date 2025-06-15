#!/bin/bash

# Data is stored inside a mounted volume
# which is symlinked to home dir.
#
# Data must be named `output.mbtiles`
#
# Note: dir and files must be owned by `root``
# sudo chown -R  root:root DIR
# sudo chmod -R 755 DIR
#
# unlink mounted-data
# ln -s /mnt/HC_Volume_100222341/data mounted-data
#
# To list drives:
# lsblk

# -d deattached

docker run -d --restart unless-stopped \
  -v "~/mounted-data":/data/mbtiles \
  -v "$(pwd)/src/vector-tiles/data":/data \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl:v4.10.3 -p 8080

# TODO(kacper): this needs to be run from home dir.
# But it should be updated to not care about the current dir.
