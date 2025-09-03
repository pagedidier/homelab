# K8s

In this folder there are all the values files of helm charts used to install it in a kubernetes cluster

## Environment override

_Used only for self developped application and chart_

Exemple:
 - The public url is different for each environment
 - The ressources allocated to the pod are not the same in different enviroment

## Strucure

```bash
.
├── <app_name>
    └── <app_name>.<env>.values.yaml
```

## Install chart

It takes some parameters as the installation will mainly be done by a CI/CD pipeline

```bash
appname=$1
environment=$2
version=$3

tee cicd-values.yaml <<EOF
environment: $environment
version: "$version"
EOF

yq '. *= load("cicd-values.yaml")' ./$appname/$appname.$environment.values.yaml > values.yaml
helm upgrade --install $appname ../charts/$appname/ --values=../k8s/values.yaml -n $appname

```

```bash
./install.sh <app_name> <enviroment> <version>
```