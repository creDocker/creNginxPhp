#!/bin/sh 

#https://geekflare.com/monitor-analyze-access-logs-goaccess/


#Country: 3MB
## https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=YOUR_LICENSE_KEY&suffix=tar.gz
# City: 30MB
## https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=YOUR_LICENSE_KEY&suffix=tar.gz

## https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN&license_key=YOUR_LICENSE_KEY&suffix=tar.gz

## if [ /var/log/nginx/php.access.log -nt /cre/$CRE_PHP_ROOT/access.html ] ; then
if [ -f /var/log/nginx/php.access.log ]; then
  if [ $(echo " $CRE_VERSION < 2020.0" | bc) -eq 1 ] ; then
    goaccess -f /var/log/nginx/php.access.log   --log-format="%h %^[%d:%^] \"%r\" %s %b \"%R\" \"%u\"" --date-format=%d/%b/%Y --time-format=%T --log-format=COMBINED > /cre/$CRE_PHP_ROOT/access.html
  else
    goaccess /var/log/nginx/php.access.log -o /cre/$CRE_PHP_ROOT/access.html --anonymize-ip --log-format=COMBINED
  fi

  mkdir -p /cre/$CRE_PHP_ROOT/access
  cp -f /cre/$CRE_PHP_ROOT/access.html /cre/$CRE_PHP_ROOT/access/access_w$(date +"%V").html 

fi

#https://www.learn2torials.com/a/how-to-rotate-nginx-logs
# /etc/logrotate.conf  'su root syslog' -> 'su root adm'   





#goaccess php2.access.log -o access.html --anonymize-ip --log-format=COMBINED --enable-geoip=mmdb --geoip-database /home/kmicha/Downloads/GeoLite2-Country_20230131/GeoLite2-Country.mmdb

#goaccess php2.access.log -o access.html --anonymize-ip --log-format=COMBINED --enable-geoip=mmdb --geoip-database /home/kmicha/Downloads/GeoLite2-ASN_20230131/GeoLite2-ASN.mmdb
