#!/bin/bash  
echo "Starting MySQL..."
/etc/init.d/mysql start

echo "Running dev/build..."
cd /var/www
sudo -u www-data ./framework/sake dev/build

echo "Starting apache..."
apache2ctl start

echo "Showing access.log..."
tail -f /var/log/apache2/access.log
