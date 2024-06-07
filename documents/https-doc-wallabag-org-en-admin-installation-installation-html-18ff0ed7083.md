* [Installation](#installation)
   * [On a dedicated web server (recommended way)](#on-a-dedicated-web-server-recommended-way)
   * [On shared hosting](#on-shared-hosting)
   * [Usage of wallabag.it](#usage-of-wallabagit)
   * [Installation with Docker](#installation-with-docker)
      * [Command to launch container](#command-to-launch-container)
   * [Installation on Cloudron](#installation-on-cloudron)
   * [Installation on YunoHost](#installation-on-yunohost)
   * [Installation on alwaysdata](#installation-on-alwaysdata)
   * [Installation on Synology](#installation-on-synology)

## [](#on-a-dedicated-web-server-recommended-way)On a dedicated web server (recommended way)

To install wallabag itself, you must run the following commands:

```vim
git clone https://github.com/wallabag/wallabag.git
cd wallabag && make install

```

If it's your first installation, you can safely answer "yes" when asking to reset the database.

Now, read the next step to create your virtual host, then access your wallabag.

To define parameters with environment variables, you have to set these variables with `SYMFONY__` prefix, for example, `SYMFONY__DATABASE_DRIVER`. You can have a look at [Symfony documentation](http://symfony.com/doc/current/cookbook/configuration/external%5Fparameters.html).

If you want to use SQLite to store your data, please put `%kernel.root_dir%/../data/db/wallabag.sqlite` for the `database_path` parameter during installation.

If you're installing Wallabag behind Squid as a reverse proxy, make sure to update your `squid.conf` configuration to include `login=PASS` in the `cache_peer` line. This is necessary for API calls to work properly.

We provide a package with all dependencies inside. The default configuration uses MySQL for the database. To add the setting for your database, please edit `app/config/parameters.yml`. Beware that passwords must be surrounded by single quotes (').

We have already created a user: the login and password are `wallabag`.

With this package, wallabag doesn't check for mandatory extensions used in the application (theses checks are made during `composer install`when you have a dedicated web server, see above).

Execute this command to download and extract the latest package:

```ada
wget https://wllbg.org/latest-v2-package && tar xvf latest-v2-package

```

You will find the [md5 hash of the latest package on our website](https://wallabag.org/en#download).

The static package requires each command to be appended by `--env=prod` as the static package is only usable as a prod environment (dev environment is not supported and won't work at all).

Now, read the next step to create your virtual host.

You must create your first user by using the command `php bin/console wallabag:install --env=prod`If an error occurs at this step due to bad settings, you must clear the cache with `php bin/console cache:clear --env=prod` before you try again the previous command.

Then you can access your wallabag.

## [](#usage-of-wallabagit)Usage of wallabag.it

[wallabag.it](https://wallabag.it/) is a paid service to use wallabag without installing it on a web server.

This service always ships the latest release of wallabag. [You can create your account here](https://app.wallabag.it/). Try it for free: you'll get a 14-day free trial with no limitation (no credit card information required).

## [](#installation-with-docker)Installation with Docker

We provide you a Docker image to install wallabag easily. Have a look at our repository on [Docker Hub](https://hub.docker.com/r/wallabag/wallabag/) for more information.

### [](#command-to-launch-container)Command to launch container

```nginx
docker pull wallabag/wallabag

```

## [](#installation-on-cloudron)Installation on Cloudron

Cloudron provides an easy way to install webapps on your server with a focus on sysadmin automation and keeping apps updated. wallabag is packaged as a Cloudron app and available to install directly from the store.

[Install wallabag on your Cloudron](https://cloudron.io/store/org.wallabag.cloudronapp2.html)

## [](#installation-on-yunohost)Installation on YunoHost

YunoHost provides an easy way to install webapps on your server with a focus on sysadmin automation and keeping apps updated. wallabag is packaged as an official YunoHost app and is available to install directly from the official repository.

[![Install wallabag with YunoHost](https://proxy-prod.omnivore-image-cache.app/0x0,sJOowt6J8YxUCh4ozA1AO2Gzfw0PUxpVHYFl8X5p4TqQ/https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=wallabag2)

## [](#installation-on-alwaysdata)Installation on alwaysdata

alwaysdata's Marketplace allows to easily install wallabag (and many other applications) on a Public or Private Cloud.

[Install wallabag on alwaysdata](https://www.alwaysdata.com/en/marketplace/wallabag/)

## [](#installation-on-synology)Installation on Synology

The SynoCommunity provides a package to install wallabag on your Synology NAS.

[Install wallabag with Synology](https://synocommunity.com/package/wallabag)

##  results matching ""

## No results matching ""