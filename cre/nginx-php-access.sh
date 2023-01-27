#!/bin/sh 

#https://geekflare.com/monitor-analyze-access-logs-goaccess/

##if [ "$CRE_VERSION" --eq "2016.0" ]
if [ $(echo " $CRE_VERSION < 2018.0" | bc) -eq 1 ] ; then
then
  goaccess -f /var/log/nginx/php.access.log   --log-format="%h %^[%d:%^] \"%r\" %s %b \"%R\" \"%u\"" --date-format=%d/%b/%Y --time-format=%T --log-format=COMBINED > /cre/$CRE_PHP_ROOT/access.html
else
  goaccess /var/log/nginx/php.access.log -o /cre/$CRE_PHP_ROOT/access.html --anonymize-ip --log-format=COMBINED
fi

mkdir -p /cre/$CRE_PHP_ROOT/access
cp -f /cre/$CRE_PHP_ROOT/access.html /cre/$CRE_PHP_ROOT/access/access_w$(date +"%V").html 

#https://www.learn2torials.com/a/how-to-rotate-nginx-logs
# /etc/logrotate.conf  'su root syslog' -> 'su root adm'   

