FROM wodby/varnish:6.0-4.4.8

# add varnish exporter
COPY prometheus_varnish_exporter-1.5.2.linux-386/prometheus_varnish_exporter /usr/bin/prometheus_varnish_exporter
RUN chmod u+x /usr/bin/prometheus_varnish_exporter

# run exporter when start container
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

# overide varnish config
COPY varnishd /etc/init.d/varnishd2
RUN chmod u+x /etc/init.d/varnishd2
COPY passwd.template /etc/passwd
COPY vcl_backend_response.vcl.tmpl /etc/gotpl/defaults/vcl_backend_response.vcl.tmpl
COPY vcl_recv.vcl.tmpl /etc/gotpl/defaults/vcl_recv.vcl.tmpl
COPY vcl_hit.vcl.tmpl /etc/gotpl/defaults/vcl_hit.vcl.tmpl

# change permission
#RUN chmod -R a+rwx /etc/varnish /var/cache/varnish /var/log/varnish /var/lib/varnish
#RUN chown -R 1001:0 /etc/varnish /var/cache/varnish /var/log/varnish /var/lib/varnish /etc/init.d/varnishd
RUN chmod -R 777 /etc/varnish /var/cache/varnish /var/log/varnish /var/lib/varnish /etc/init.d/varnishd /etc/init.d/varnishd2 /etc/passwd /etc

USER varnish

CMD ["/etc/init.d/varnishd2"]