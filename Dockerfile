FROM nimmis/alpine-apache

LABEL maintainer="nimmis <kjell.havneskold@gmail.com>" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.name="Apache2/php7 on Alpine OS" \
      org.label-schema.url="https://www.nimmis.nu" \
      org.label-schema.vcs-url="https://github.com/nimmis/docker-alpine-apache-php7.git"

RUN  apk update && apk upgrade && \

    # Make info file about this build
    printf "Build of nimmis/alpine-apache-php7, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/alpine-apache-php7 && \

    apk add libressl && \
    apk add curl openssl && \

    apk add php7 php7-apache2 php7-openssl php7-mbstring && \
    apk add php7-apcu php7-intl php7-mcrypt php7-json php7-gd php7-curl && \
    apk add php7-fpm php7-mysqlnd php7-pgsql php7-sqlite3 php7-phar && \
    # waiting for module to be release on alpine
    # apk add php7-imagick@testing

    # fix compatible with old scripts
    ln -s /usr/bin/php7 /usr/bin/php && \

    # install composer
    cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \

    #clear cache
    rm -rf /var/cache/apk/*


