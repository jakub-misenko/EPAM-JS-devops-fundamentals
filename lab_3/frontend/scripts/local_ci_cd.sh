#!/bin/sh

cd ..
npm audit
npm run test
npm run build

# source ./build -- not working
npm run build

scp -r ./dist/app sshuser@192.168.128.2:/var/www/app
