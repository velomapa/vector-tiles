# Velomapa vector tiles

Scripts and instructions for generating (planetiler) vector tiles and running tile server (tileserver-gl).
Velomap vector style is based on [OSM-liberty](https://github.com/maputnik/osm-liberty).

## Genereting Tiles

Scripts for building Europe vector tiles using https://github.com/onthegomap/planetiler.
Tiles without any details will be also generated for whole planet (extra ~25GB).

### Running

```bash
mkdir ./src
cd src
git clone git@github.com:velomapa/vector-tiles.git
cd ~

bash ./src/vector-tiles/generate_tiles.sh
```

### Planetiler Options

* `--nodemap-storage=mmap` - requires 0.5x of the xxx.osm.pbf input size
* `--nodemap-storage=ram` - requires 1.5x of the xxx.osm.pbf input size
* `--bounds=planet` - it will generate tiles without details for whole planet - adds extra ~25GB to the output file

### Results

* server `CPX51 16 VCPU; 32 GB RAM; 360 GB SSD`
* mbtiles	`53GB`
* time `1h39m38s`

### Runing tileserver

*NOTE:* this will expose 8008 port outside of the firewall

```bash
docker run --rm -it -v "$(pwd)/data":/data -p 8080:8080 maptiler/tileserver-gl -p 8080
```

### Moving file between servers

* `nohup` - it will make sure that command will still run after loging out, NOTE: `&` is needed

```bash
nohup rsync --progress USER@X.X.X.X:/root/data/output.mbtiles ./data &

tail -f nohup.out
```

### Adding Docker to sudo

```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```

## Running tile server on smaller VPS

### Basic Nginx setup and SSL

```bash
sudo apt install nginx

# firewall config
sudo ufw allow 'Nginx Full'

sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d tiles.velomapa.pl

# auto renewal
sudo systemctl status certbot.timer

# testing renewal process
sudo certbot renew --dry-run
```

### Tileserver and reverse proxy

* `-d` detached mode

```bash
docker run -d --restart unless-stopped -v "$(pwd)/data":/data -p 127.0.0.1:8080:8080 maptiler/tileserver-gl -p 8080
```

```nginx
location ~*  \.(jpg|jpeg|png|webp)$ {
  proxy_set_header X-Real-IP         $remote_addr;
  proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Forwarded-Host  $host;
  proxy_set_header X-Forwarded-Port  $server_port;
  proxy_set_header Host              $host;
  add_header Cache-Control "public, max-age=604800";

  proxy_pass http://127.0.0.1:8080;
}

location / {
  proxy_set_header X-Real-IP         $remote_addr;
  proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Forwarded-Host  $host;
  proxy_set_header X-Forwarded-Port  $server_port;
  proxy_set_header Host              $host;

  proxy_pass http://127.0.0.1:8080;
}
```


restart nginx
```
sudo systemctl restart nginx
```
