# description
Bản Apache PHP có cài thêm xdebug

## Enable xdebug request
Add "XDEBUG_PROFILE=StartProfileForMe" (ex: http://localhost/s/login?XDEBUG_PROFILE=StartProfileForMe)

## Mở file cache do xdebug sinh ra bằng qcachegrind

## command
```shell
docker build -t icovn/base_php_apache:7.4.33_5_xdebug .
docker push icovn/base_php_apache:7.4.33_5_xdebug
```