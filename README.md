# Docker Tiny Tiny RSS

[Tiny Tiny RSS](https://tt-rss.org/) running in Alpine with Nginx and PHP-FPM.

## Usage

The Tiny Tiny RSS website explains they've built for a PostgreSQL backend and strongy recommends using PostgreSQL. As a result, to reduce image size, the default build here only supports PostgreSQL:

```
docker run --name tt-rss -d -p 8080:8080 moonbuggy2000/tt-rss:latest
```

If you need to use MySQL/MariaDB instead a separate build tag is available:

```
docker run --name tt-rss -d -p 8080:8080 moonbuggy2000/tt-rss:mysql
```

### Environment variables

Environment variables can be specified with the `-e` flag or in `docker-compose.yml`. Available environment variables are:

* ``TT_ADMIN_USER``  - admin user login (defailt: `admin`)
* ``TT_ADMIN_PASS``  - admin user password (default: `password`)
* ``TT_DB_HOST``     - database server hostname or IP
* ``TT_DB_PORT``     - database server port (defaults to standard port for database type)
* ``TT_DB_NAME``     - database name
* ``TT_DB_USER``     - database user name
* ``TT_DB_PASS``     - database user password
* ``TT_URL_PATH``    - root URL for Tiny Tiny RSS (e.g. `http://tt-rss.local:8080/`)
* ``TT_FEED_PERIOD`` - time, in minutes, between feed updates (default: `15`)
* ``TT_REPO_UPDATE`` - pull latest TT-RSS source from repo at container start (accepts: `true`, `false` default: `true`)
* ``NGINX_LOG_ALL``  - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)

#### TT_FEED_PERIOD

Accepts from `15` to `1440` (1 day), values outside these limits will be set at the limit. Values between `60` and `1440` will be rounded to the nearest whole hour.

#### TT_DB_TYPE

If you want an image that supports both PostgreSQL and MySQL/MariaDB you can find it under the `both` tag. The type of database for this image can (and must) be specified with the environment variable `TT_DB_TYPE`, which accepts `pgsql` or `mysql`.

## Links

* GitHub: https://github.com/moonbuggy/docker-tt-rss
* DockerHub: https://hub.docker.com/r/moonbuggy2000/tt-rss
