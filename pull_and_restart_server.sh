#!/bin/bash

# TODO(kacper): make sure that the script is run from the root of the repository
cd src/vector-tiles
git pull
cd ../..
docker stop $(docker ps -a -q --filter ancestor=maptiler/tileserver-gl)
bash ./src/vector-tiles/run_tileserver.sh
