# NPM to Mailu SSL Cron script
Simple bash script to update Mailu SSL cert 

The script will get MD5 of NPM source SSL certificate and Mailu certificate, if diffrent, meaning NPM obtained new cert from letsencrypt it will copy to Mailu location and restart mailu-front 

### How to use

This script is only for Mailu behind Ngnix Proxy Manager with setting `TLS_FLAVOR=cert`

All you need is to adjust the script path for your NPM's data location and folder name that keep SSL cert desired, and the output paths.
If you run in non root user, you may need to `chown ...` the certs in Mailu cert destination.

### The cron job

This script could ran either from cron container or host's crontab. For Host use somethig like 
`*/5 * * * * /your-path-to-script/update-ssl-cert.sh`

For cron container, the paths in the scripts can be simplified to 
```
/src
/dest
```

In docker compose map 
```
  volumes
    - /root/containers/npm/letsencrypt/live:/src
    - /mailu/certs:/dest
```

The script included into a container
```
NPM_CERT_FOLDER=npm-xx #folder name of your desired cert
NPM_LOC=/src
MAILU_LOC=/dest

...
```