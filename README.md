# Pgpool docker image based on alpine linux

A minimal pgpool docker image based on alpine linux with memcached support.

## Usage

### Quick start

`docker run -d -p 9999:9999 -p 9898:9898 hegand/pgpool`

### Attach config files

`docker run -d -p 9999:9999 -p 9898:9898 -v /local/dir/pgpool.conf:/etc/pgpool.conf:ro -v /local/dir/pool_passwd:/etc/pool_passwd:rw -v /local/dir/pool_hba.conf:/etc/pool_hba.conf:ro  hegand/pgpool`

More info about pgpool setup: [offical pgpool site](http://www.pgpool.net/docs/latest/pgpool-en.html)
