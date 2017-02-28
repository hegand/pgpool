FROM hegand/alpine:3.5

ENV PGPOOL_VERSION 3.6.1

ENV PG_VERSION 9.6.2-r0

ENV LANG en_US.utf8
    
RUN apk --update --no-cache add libpq=${PG_VERSION} postgresql-dev=${PG_VERSION} postgresql-client=${PG_VERSION} \
                                linux-headers libmemcached libmemcached-dev \
                                gcc make libgcc g++ && \
    cd /tmp &&\ 
    wget http://www.pgpool.net/mediawiki/images/pgpool-II-${PGPOOL_VERSION}.tar.gz -O - | tar -xz && \
    chown root:root -R /tmp/pgpool-II-${PGPOOL_VERSION} && \
    cd /tmp/pgpool-II-${PGPOOL_VERSION} && \
    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info \ 
		--with-memcached-dir=/usr/include/libmemcached && \
    make && \
    make install && \
    rm -rf /tmp/pgpool-II-${PGPOOL_VERSION} && \
    apk del postgresql-dev \
            linux-headers libmemcached-dev \
            gcc make libgcc g++
    
RUN mkdir /var/run/pgpool /var/log/pgpool && chown postgres /var/run/pgpool /var/log/pgpool
                   
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9999 9898

CMD ["pgpool","-n"]
