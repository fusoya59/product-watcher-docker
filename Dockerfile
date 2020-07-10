FROM product-watcher:latest

USER root

ENV NODE_PATH /usr/bin/node
ENV WATCHLIST_FILE /product-watcher/watchlist.json
ENV LOG_LEVEL info

# notify only when something's in stock.
# ENV IN_STOCK_NOTIFICATION_ONLY 1

# email to send notifications to
# ENV TO_EMAIL <email>

# URL endpoint to trigger notifications
# ENV NOTIFICATION_URL <url>

# Add crontab file in the cron directory
ADD configs/crontab /etc/cron.d/product-watcher

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/product-watcher

# Create the log file to be able to run tail
RUN touch /var/log/product-watcher.log

# Install Cron and logrotate
RUN apt-get update
RUN apt-get -y install cron logrotate

# Add the script to launch product-watcher
ADD scripts/product-watcher.sh /product-watcher
RUN chmod +x /product-watcher/product-watcher.sh

# Add logrotate config
ADD configs/logrotate.conf /etc/logrotate.d/product-watcher.conf

# Special entrypoint to preserve env for cron
ADD scripts/entrypoint.sh /product-watcher/entrypoint.sh
RUN chmod +x /product-watcher/entrypoint.sh

# Run entrypoint.sh to load environment vars and run cron
CMD ["/bin/bash", "-c", "/product-watcher/entrypoint.sh"]
