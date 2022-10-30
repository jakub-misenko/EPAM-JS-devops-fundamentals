#!/bin/sh

cd ..
npm audit
npm run test

# source ./build -- not working
npm run build

rsync -aP ./dist/app sshuser@192.168.128.2:/var/www/html
