# Homelab

This repository contains configuration for my personal homelab environment. 
It includes various orchestration tools, containerization platforms, and infrastructure automation to
manage a distributed system running multiple services.

This project serves as both a practical implementation and a learning platform for modern DevOps practices and
infrastructure management.

The infrastructure is designed with a "configuration as code" mindset, emphasizing declarative specifications over
imperative commands. 
This approach ensures reproducibility, version control capabilities, and clear documentation
of the entire system state, making it easier to maintain, modify, and scale the infrastructure.

The current work is to import all manual or semi-automatic configuration into this repository in order to have one source of truth.

## Layered architecture

The focus in this repository is to split the infrastructure in layers where each layer have is own set of tools to configure it.

| Layer                 | Tool                 | location in repository                                 |
| --------------------- | -------------------- | ------------------------------------------------------ |
| Infrastructure        | terraform            | [./terraform/infra](./terraform/infra)                 |
| Runtime Configuration | Ansible              | [./ansible](./ansible)                                 |
| Platform              | terraform            | [./terraform/platform](./terraform/platform)           |
| Application           | Helm, docker compose | [./charts](./charts) [./k8s](./k8s) [./swarm](./swarm) |


## Tech stack overview

| Logo                                                         | Name                                                         | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://avatars.githubusercontent.com/u/2678585?s=50)    | [Proxmox virtual environment](https://pve.proxmox.com/wiki/Main_Page) | Virtualization platform that combines virtual machines, containers, software-defined storage, and networking into a single, easy-to-manage solution. |
| ![](https://avatars.githubusercontent.com/u/2678585?s=50)    | [Proxmox Backup server](https://pbs.proxmox.com/docs/index.html) | Enterprise-grade, open-source backup solution designed to efficiently back up and restore virtual machines, containers, and physical hosts. |
| ![](https://avatars.githubusercontent.com/u/11051457?s=50)   | [Terraform](https://developer.hashicorp.com/terraform)       | Infrastructure as Code (IaC) tool that lets you provision, manage, and version infrastructure across cloud and on-prem environments using a declarative configuration language. |
| ![](https://avatars.githubusercontent.com/u/1507452?s=50)    | [Ansible](https://docs.ansible.com/)                         | Automation tool that uses simple, agentless, declarative playbooks to manage configuration, application deployment, and IT orchestration across systems. |
| ![](https://avatars.githubusercontent.com/u/49319725?s=50)   | [K3s](https://docs.k3s.io/)                                  | A lightweight, certified Kubernetes distribution designed for resource-constrained environments, edge computing, and simplified cluster deployment. |
| ![](https://avatars.githubusercontent.com/u/7739233?s=50)    | [Docker](https://www.docker.com/)                            | Platform that enables developers to build, package, and run applications in lightweight, portable containers. |
| ![](https://avatars.githubusercontent.com/u/15859888?s=50)   | [Helm](https://helm.sh/)                                     | Package manager for Kubernetes that simplifies the deployment, versioning, and management of applications using reusable charts. |
| ![](https://avatars.githubusercontent.com/u/3380462?s=50)    | [Prometheus](https://prometheus.io/)                         | Monitoring and alerting system that collects metrics, stores them in a time-series database, and provides powerful querying and visualization capabilities. |
| ![](https://avatars.githubusercontent.com/u/7195757?s=50)    | [Grafana](https://grafana.com/)                              | Analytics and visualization platform that lets you create interactive dashboards from metrics, logs, and other data sources. |
| ![](https://avatars.githubusercontent.com/u/38220289?s=50)   | [HaProxy](https://www.haproxy.com/)                          | High-performance load balancer and reverse proxy that distributes network traffic across servers to ensure reliability and scalability. |
| ![](https://avatars.githubusercontent.com/u/14280338?s=50)   | [Traefik](https://traefik.io/traefik)                        | Modern, cloud-native reverse proxy and load balancer that automatically discovers and routes traffic to your services across dynamic environments like Docker, Kubernetes, and microservices architectures. |
| ![](https://icon.icepanel.io/Technology/svg/HashiCorp-Vault.svg) | [Vault](https://www.hashicorp.com/en/products/vault)         | Tool for securely managing secrets, encryption keys, and sensitive data, with dynamic access control and audit capabilities. |
| ![](https://avatars.githubusercontent.com/u/1086321?s=50)    | [Gitlab](https://gitlab.com/)                                | Web-based DevOps platform that provides Git repository management, CI/CD pipelines, and collaborative software development tools in a single application. |
| ![](https://avatars.githubusercontent.com/u/13991055?s=50)   | [WireGuard](https://www.wireguard.com/)                      | WireGuard is a lightweight, modern VPN protocol that uses state-of-the-art cryptography to securely connect devices over the internet. |
## Overview of main features
 - Single internet entrypoint
 - Automatic backup with proxmox backup server 
 - Automatic VM/LXC configuration with terraform
 - Automatic DNS configuration with terraform
 - Dynamic ansible inventory file based on terraform configuration
 - Automatic gitlab CI/CD variable for kubernetes authentification (rbac)
 - Automatic kubernetes namespace configuration
 - Application of configuration (Terraform and Ansible) using gitlab-ci
 - Remote terraform storage on gitlab
 - Local CI/CD execution with gitlabrunners
 - Ansible configuration of k8s and docker runtime


## Todo
 - Checkout the current open [issues](https://gitlab.com/two-p/homelab/-/issues)

## Advanced learning objectives

 - Setup and manage a multi-tenant kubernetes
 - Learn advanced gitops approach
 - Managing a multi-region setup of kubernetes clusters for high availability
 - Have a look on advenced OS like Talos or NixOS