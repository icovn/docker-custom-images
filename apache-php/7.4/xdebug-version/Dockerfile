FROM icovn/base_php_apache:7.4.33_5

RUN pecl install xdebug-3.1.5
RUN docker-php-ext-enable xdebug

COPY ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini