# Product Watcher Docker
Runs product-watcher in Docker every hour. The base of this Docker image comes 
from this repo: [product-watcher](https://github.com/fusoya59/product-watcher).
Make sure to build product-watcher before building this image.

# Installation
Build the image:
```
$ docker build -t product-watcher-docker .
```

# Usage
Optional environment variables can be set before running the container:

`NODE_PATH` : string - the node executable inside the container.
Defaults to `/usr/bin/node`.

`WATCHLIST_FILE` : string - the watch list configuration file. Defaults
to `/product-watcher/watchlist.json`.

`LOG_LEVEL` : string - specify either `trace`, `error`, `debug`, `info`, `warn`
or `silent`. Defaults to `info`.

`TO_EMAIL` : string - the email to send notifications to. 

`NOTIFICATION_URL` : string - URL that will trigger notifications when a
product is in stock.

`IN_STOCK_NOTIFICATION_ONLY` : string - set this to any value if you want to
be notified only when product(s) are in stock. 


Example docker run:
```
$ docker run -d \
  --env LOG_LEVEL=info \
  --env TO_EMAIL=helloworld@gmail.com \
  --env NOTIFICATION_URL=https://notify.me \
  --rm \
  --name product-watcher-docker \
  product-watcher-docker:latest
```