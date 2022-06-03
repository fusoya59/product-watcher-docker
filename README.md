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

`FROM_EMAIL` : string - sender email. 

`NOTIFICATION_PLUGIN` - the plugin to use for notification API. Defaults to 'sendgrid'

`NOTIFICATION_URL` - some endpoint that'll trigger a notification.

`SENDGRID_API_KEY` - the sendgrid API key used to for email API.

`IN_STOCK_NOTIFICATION_ONLY` : string - set this to any value if you want to
be notified only when product(s) are in stock. 


Example docker run:
```
$ docker run -d \
  --env LOG_LEVEL=info \
  --env TO_EMAIL=fusoya59@gmail.com \
  --env FROM_EMAIL=fusoya59@gmail.com \
  --env NOTIFICATION_PLUGIN=sendgrid \  
  --env NOTIFICATION_URL=https://api.sendgrid.com/v3/mail/send \
  --env SENDGRID_API_KEY=apikey \
  --rm \
  --name product-watcher-docker \
  product-watcher-docker:latest
```