# Ansible

The main goal of ansible is to configure the different servers (bare metal and virtual) at the _os layer_ like setuping
 - basic utils package
 - users
 - firewall
 - docker engine
 - Some clean up cron
 - Log managmennt (not yet)

In some case it configure some applications:
 - HaProxy: It upload the config file and restart the service
 - Deploy docker compose file for graphite_exporter

But at term this should be managed at _application layer_ and should be delegate to docker or something else.
It may be an another ansible configuration. It need to be architectured.

## Inventory

The `inventory.yaml` file generated based on the output of the terraform/infra configuration it has the needed information like hostname, ip, port, user to run ansible on the host

## Playbooks

In that folder, we declare all the playbooks to run on the infrastructure. It's designed to have the _initial setup_ playbook. That mean that there is no current playbook that is responsible to do a one time task. There is no playbook to remove or delete things.
These two playbooks type can come later if needed

All the playbooks are linked in a main yaml file `site-homelab.yaml`  that can be run to apply all the configs
A sub playbook represent a group of roles. That group of roles usually defines the type of servers.

## Roles

Roles are small unit of ansible task that can be include in any playbook.
A role can be installed from ansible-galaxy

## Requirments

The computer that runs the playbook should have access to all the servers with ssh

## Usage

**Be sure to have setuped the terraform/infra as the following scripts need it.**
```bash
./generate_inventory.sh
ansible-playbook playbooks/site-homelab.yaml -i inventory/inventory.yaml
```


