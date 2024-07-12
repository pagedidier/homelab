#!/bin/bash

appname=$1
environment=$2

tee cicd-values.yaml <<EOF
version: "$environment"
EOF




yq '. *= load("cicd-values.yaml")' ./$appname/$appname.$environment.values.yaml > values.yaml
helm upgrade --install $appname ../charts/$appname/ --values=../k8s/values.yaml -n $appname

rm cicd-values.yaml
rm values.yaml
