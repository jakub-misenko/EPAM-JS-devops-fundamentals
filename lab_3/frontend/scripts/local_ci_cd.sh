#!/bin/sh

cd ..
npm audit
npm run test

# source ./build -- not working
npm run build

# make sure sshusesr is in www-data group
rsync -rP ./dist/app/ sshuser@192.168.128.2:/var/www/html
