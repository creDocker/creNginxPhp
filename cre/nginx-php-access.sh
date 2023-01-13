#!/bin/sh 

#https://geekflare.com/monitor-analyze-access-logs-goaccess/

goaccess /var/log/nginx/php.access.log -o /cre/$CRE_PHP_ROOT/access.html --anonymize-ip --log-format=COMBINED
mkdir -p /cre/$CRE_PHP_ROOT/access
cp -f /cre/$CRE_PHP_ROOT/access.html /cre/$CRE_PHP_ROOT/access/access_w$(date +"%V").html 

#https://www.learn2torials.com/a/how-to-rotate-nginx-logs
# /etc/logrotate.conf  'su root syslog' -> 'su root adm'   

