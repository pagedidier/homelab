#!/bin/bash

appname=$1
environment=$2
version=$3

tee cicd-values.yaml <<EOF
environment: $environment
version: "$version"
EOF

yq '. *= load("cicd-values.yaml")' ./$appname/$appname.$environment.values.yaml > values.yaml
helm upgrade --install $appname ../charts/$appname/ --values=../k8s/values.yaml -n $appname

rm cicd-values.yaml
rm values.yaml
