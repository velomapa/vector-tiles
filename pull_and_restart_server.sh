#!/bin/bash

cd src/vector-tiles
git pull
cd ../..
docker stop $(docker ps -a -q)
bash ./src/vector-tiles/run-tileserver.sh
