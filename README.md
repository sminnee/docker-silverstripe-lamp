# docker-silverstripe-lamp

## Introduction

This is the source of a Docker image you can use to run a SilverStripe development environment.
You can use it to create a LAMP stack suitable for running SilverStripe, including an internal database.

 * Uses Debian Wheezy with Backports
 * Run SilverStripe tests
 * Run SilverStripe release-packaging steps

A number of support tools are installed:

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
  * Build tools (build-essential, ruby-dev)

To help with headless download of packages, it has the github.com SSH key loaded as a known host.

**NOTE:** This should only be used for development purposes; the root database user has no password.

## Usage

To run a build and execute unit tests, mount your SilverStripe root as `/var/www` and execute commands there:

    build_dir=`pwd`
    docker run -v $build_dir:/var/www sminnee/silverstripe-lamp -c 'composer install; phpunit'

To run a working instance of your SilverStripe code on a fresh database, run the image without
a command. In this example, we map port 3000 to the HTTP port of the container.

    build_dir=`pwd`
    docker run -dP -p 3000:80 -v $build_dir:/var/www sminnee/silverstripe-lamp

## Vagrant

If you're using Vagrant, a basic `Vagrantfile` is provided that uses the [Vagrant docker provider](https://docs.vagrantup.com/v2/docker/basics.html). This is especially useful for
OS X, as there's currently no way to natively run containers.

Run this command from within the directory where you cloned this repo:

	vagrant up --provider=docker

This will create a default host VM (if one isn't currently running) and install `docker` on it. This
VM will be the host to the new docker container.

Once the host VM and container have started, you can check they are running using [`vagrant global-status`](https://docs.vagrantup.com/v2/cli/global-status.html) and the usual [vagrant commands](https://docs.vagrantup.com/v2/cli/index.html) to
control them.

[Vagrant docker configuration commands](https://docs.vagrantup.com/v2/docker/configuration.html) are available for customising the `Vagrantfile`. For example, you may want to use a different host image, rather than the default.
