# Planetiler Scripts

Scripts for building Vector tiles using https://github.com/onthegomap/planetiler.

## Running

```bash
bash ./do_magic.sh
```

## Planetiler Options

* `--nodemap-storage=mmap` - requires 0.5x of the xxx.osm.pbf input size
* `--nodemap-storage=ram` - requires 1.5x of the xxx.osm.pbf input size
* `--bounds=planet` - it will generate tiles without details for whole planet - adds extra ~25GB to the output file
