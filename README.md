[sminnee/silverstripe-lamp](https://registry.hub.docker.com/u/sminnee/silverstripe-lamp/)
=========================
Docker image
------------

This is the source of a Docker image that you can use to do a number of SilverStripe-related things:

 * Run a LAMP stack suitable for SilverStripe (including an internal database)
 * Uses Debian Wheezy with Backports
 * Run SilverStripe tests
 * Run SilverStripe release-packaging steps

A number of support tools are available:

  * PHPUnit (PHP)
  * Phing (PHP)
  * Composer (PHP)
  * NodeJS (JavaScript)
  * NPM (JavaScript)
  * Grunt (JavaScript)
  * Gulp (JavaScript)
  * RubyGems (Ruby)
  * Bundler (Ruby)
  * Compass (Ruby)

To help with headless download of packages, it has the github.com SSH key loaded as a known host.

Usage
-----

To run a build comment, mount your SilverStrpe root as `/var/www` and execute commands there:

    build_dir=`pwd`
    docker run -v $build_dir:/var/www sminnee/silverstripe-lamp bash -c 'composer install; phpunit'

To run a working instance of your SilverStripe code on a fresh database, run the image without
a command. In this example, we have mapped port 3000 to the HTTP port of the container.

    build_dir=`pwd`
    docker run -dP -p 3000:80 -v $build_dir:/var/www sminnee/silverstripe-lamp

**Note:** This is for development purposes only; the root database user has no password.

Development
-----------

To rebuild this image locally, use the Makefile included:

    git clone https://github.com/sminnee/docker-silverstripe-lamp.git
    cd docker-silverstripe-lamp
    make
