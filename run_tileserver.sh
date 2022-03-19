#!/bin/bash

docker run -d --restart unless-stopped \
  -v "$(pwd)/data":/data \
  -v "$(pwd)/src/vector-tiles/sprites":/app/node_modules/tileserver-gl-styles/sprites \
  -v "$(pwd)/src/vector-tiles/styles/velomap":/app/node_modules/tileserver-gl-styles/styles/velomap \
  -p 127.0.0.1:8080:8080 \
  maptiler/tileserver-gl -p 8080
