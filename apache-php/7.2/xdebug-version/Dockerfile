FROM icovn/base_php_apache:7.2.34_4

RUN pecl install xdebug-3.1.5
RUN docker-php-ext-enable xdebug

COPY ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
