#!/usr/bin/env bash

# Renew the certificate
sudo certbot renew #--force-renewal

# Concatenate new cert files
bash -c "cat /etc/letsencrypt/live/twop.ch/fullchain.pem /etc/letsencrypt/live/twop.ch/privkey.pem > /etc/ssl/twop.ch.pem"

# Reload  HAProxy config file, not sure if needed
sudo service haproxy reload