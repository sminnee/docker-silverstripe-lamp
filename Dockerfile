FROM debian:wheezy
MAINTAINER Sam Minnee <sam@silverstripe.com>

### SET UP

# BASE wheezy-backports O/S with some helpful tools
RUN echo "deb http://ftp.us.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qqy install sudo wget lynx telnet nano curl

# Known hosts
ADD known-hosts /root/.ssh/known-hosts

# APACHE
RUN apt-get -qqy install apache2

# MYSQL
RUN apt-get -qqy install mysql-server-5.5

# PHP AND SUPPORT TOOLS
RUN apt-get -qqy install php5-cli libapache2-mod-php5 php5-mysql php5-mcrypt php5-tidy php5-curl php5-gd php-pear

#  - Phpunit
RUN wget https://phar.phpunit.de/phpunit-3.7.37.phar
RUN chmod +x phpunit-3.7.37.phar
RUN mv phpunit-3.7.37.phar /usr/local/bin/phpunit

#  - Composer
RUN wget https://getcomposer.org/composer.phar
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

#  - Phing
RUN pear channel-discover pear.phing.info
RUN pear install phing/phing

# SilverStripe Apache Configuration
RUN a2enmod rewrite
RUN rm /var/www/index.html
RUN echo "date.timezone = Pacific/Auckland" > /etc/php5/conf.d/timezone.ini

ADD apache-foreground /usr/local/bin/apache-foreground
ADD apache-default-vhost /etc/apache2/sites-available/default
ADD _ss_environment.php /var/_ss_environment.php

EXPOSE 80

# Run apache in foreground mode, because Docker needs a foreground
WORKDIR /var/www
CMD ["/usr/local/bin/apache-foreground"]

####
## These are not specifically SilverStripe related and could be removed on a more optimised image

# Ruby, RubyGems, Bundler, development tools to compile Ruby modules
RUN apt-get -qqy install -t stable ruby ruby-dev build-essential
RUN gem install bundler
RUN gem install compass

# NodeJS
apt-get install nodejs-legacy
curl --insecure https://www.npmjs.org/install.sh | bash
