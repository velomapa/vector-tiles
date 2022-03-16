# Planetiler Scripts

Scripts for building Europe vector tiles using https://github.com/onthegomap/planetiler.
Tiles without any details will be also generated for whole planet (extra ~25GB).

## Running

```bash
mkdir ./src
cd src
git clone https://github.com/velomapa/planetiler-scripts.git
cd ~

bash ./src/planetiler-scripts/do_magic.sh
```

## Planetiler Options

* `--nodemap-storage=mmap` - requires 0.5x of the xxx.osm.pbf input size
* `--nodemap-storage=ram` - requires 1.5x of the xxx.osm.pbf input size
* `--bounds=planet` - it will generate tiles without details for whole planet - adds extra ~25GB to the output file
