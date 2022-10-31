#!/bin/sh

docker login --username misenkojakub

cd ..
docker build -t misenkojakub/devops-fundamentals .
docker push misenkojakub/devops-fundamentals:latest