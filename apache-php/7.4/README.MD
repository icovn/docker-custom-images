## description
Bản Apache PHP có cài thêm:
- mod_rewrite của Apache
- các extension phổ biến của PHP
- các extension khác của PHP: rdkafka, mongodb
- Cronicle
- supervisor
- cron

## command
```shell
docker build -t icovn/base_php_apache:7.4.33_5 -t icovn/base_php_apache:latest .
docker push icovn/base_php_apache:7.4.33_5
docker push icovn/base_php_apache:latest
```