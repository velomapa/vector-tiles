#!/bin/bash

cd src/vector-tiles
git pull
cd ../..
docker stop $(docker ps -a -q --filter ancestor=maptiler/tileserver-gl)
bash ./src/vector-tiles/run_tileserver.sh
