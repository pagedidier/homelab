#!/bin/sh
wget -O "ubuntu-24.04-cloudimg-amd64.qcow2" https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img


virt-customize -a "ubuntu-24.04-cloudimg-amd64.qcow2" \
  --update \
  --install qemu-guest-agent \
  --run-command 'systemctl enable qemu-guest-agent' \
  --run-command 'apt clean' \
  --run-command 'find /var/log -type f -exec truncate -s 0 {} +' \
  --run-command 'rm -f /etc/ssh/ssh_host_*' \
  --run-command 'cloud-init clean' \
  --selinux-relabel

mkdir -p build
mv ubuntu-24.04-cloudimg-amd64.qcow2 ./build