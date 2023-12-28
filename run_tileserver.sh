#!/bin/bash

# Data is stored inside a mounted volume
# which is symlinked to home dir:
# ln -s /mnt/XXXX/data mounted-data

docker run -d --restart unless-stopped \
  -v "$(pwd)/mounted-data":/data \
  -v "$(pwd)/src/vector-tiles/sprites":/app/node_modules/tileserver-gl-styles/sprites \
  -v "$(pwd)/src/vector-tiles/styles/velomap":/app/node_modules/tileserver-gl-styles/styles/velomap \
  -v "$(pwd)/src/vector-tiles/styles/velomap-grey":/app/node_modules/tileserver-gl-styles/styles/velomap-grey \
  -v "$(pwd)/src/vector-tiles/styles/osm-liberty":/app/node_modules/tileserver-gl-styles/styles/osm-liberty \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl:4.7.0 -p 8080
