FROM php:7.4.33-apache

# 1. Install development packages and clean up apt cache.
RUN apt-get update && apt-get install -y \
    curl \
    g++ \
    git \
    libbz2-dev \
    libfreetype6-dev \
    libwebp-dev \
	libgmp-dev \
    libicu-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libpng-dev \
    libreadline-dev \
	libzip-dev \
	exiftool \
    sudo \
    telnet \
    unzip \
    vim \
    zip \
	wget \
 && rm -rf /var/lib/apt/lists/*

# 2. Apache configs + document root.
RUN echo "ServerName laravel-app.local" >> /etc/apache2/apache2.conf

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 3. mod_rewrite for URL rewrite and mod_headers for .htaccess extra headers like Access-Control-Allow-Origin-
RUN a2enmod rewrite headers substitute

# 4. Start with base PHP config, then add extensions.
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-configure gd --with-freetype --with-webp  --with-jpeg

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
	exif \
	gd \
	gmp \
    iconv \
    intl \
	mysqli \
    opcache \
    pdo_mysql \
	zip

RUN pecl install redis && docker-php-ext-enable redis

# 5. Install rdkafka
RUN git clone --depth 1 https://github.com/edenhill/librdkafka.git /tmp/librdkafka && cd /tmp/librdkafka && ./configure && make -j$(nproc) && make install && rm -rf /tmp/librdkafka
RUN pecl install rdkafka
RUN docker-php-ext-enable rdkafka

# 6. Install mongodb
RUN apt update && apt install -y openssl libssl-dev pkg-config
RUN pecl install mongodb
RUN docker-php-ext-enable mongodb

# 7. Install node
RUN apt update && apt install -y nodejs npm
RUN node -v
RUN npm -v

# 8. Install Cronicle
RUN curl -s https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js | node
RUN ls -lh /opt/cronicle/

# 9. Setup supervisor
RUN apt update && apt install supervisor -y

# 10. Setup cron
RUN apt update && apt install -y cron

# 11. Composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# 12. Copy config and script
COPY ./scripts/supervisor_worker.conf /etc/supervisor/conf.d/worker.conf
RUN cat /etc/supervisor/conf.d/worker.conf

COPY ./scripts/cron_job /etc/cron.d/cron_job
RUN chmod 0644 /etc/cron.d/cron_job
RUN crontab /etc/cron.d/cron_job
RUN cat /etc/cron.d/cron_job

COPY ./scripts/start.sh /start.sh
RUN chmod 755 /start.sh
RUN chmod u+x /start.sh

COPY ./scripts/cronicle_config.json /opt/cronicle/conf/cronicle_config.json
COPY ./scripts/php.ini /usr/local/etc/php/php.ini

CMD ["/bin/bash", "/start.sh"]