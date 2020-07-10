#!/bin/bash
# we print our environment variables and send it to this file
# for cron to use
printenv | grep -v "no_proxy" > /etc/environment
cron && tail -f /var/log/product-watcher.log
