#!/bin/sh
set -e

function apply_secret {
    echo "Check that we have CRONICLE_SECRET_KEY vars"
    if [[ -z "${CRONICLE_SECRET_KEY}" ]]; then
        echo "not exist"
        MY_SCRIPT_VARIABLE=""
    else
        echo "exist"
        MY_SCRIPT_VARIABLE=$CRONICLE_SECRET_KEY
    fi
    echo $MY_SCRIPT_VARIABLE

    find /opt/cronicle/conf \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s#CRONICLE_SECRET_KEY_VAR#$MY_SCRIPT_VARIABLE#g"
}

mkdir -p /var/www/html/storage/logs
chown -R www-data:www-data /var/www/html/storage/logs/
chmod -R 777 /var/www/html/storage/logs/
printenv > /etc/environment

/usr/bin/supervisord

/usr/sbin/cron

echo "Start cronicle"
/opt/cronicle/bin/control.sh start

echo "Sleep 10s waiting for cronicle to start"
sleep 10s

echo "Replace config"
cp /var/www/html/scripts/cronicle_config.json /opt/cronicle/conf/config.json
apply_secret

echo "Restart cronicle"
/opt/cronicle/bin/control.sh restart

apache2-foreground