# Terraform Proxmox Configuration

This configuration manages Proxmox VMs and containers, and generates an Ansible inventory file for easier management.

## Ansible Integration

The configuration automatically generates an Ansible inventory file in YAML format based on the deployed infrastructure:

- Located at: `./ansible/inventory.yml`
- Generated after each `terraform apply`
- Organizes hosts into logical groups:
  - `k3s_cluster`: All Kubernetes nodes
  - `docker_swarm`: All Docker Swarm nodes
  - `containers`: All LXC containers, with subgroups for specific purposes

### Using the Generated Inventory

Once generated, you can use the inventory with Ansible commands:

```bash
# Test connectivity to all hosts
ansible -i ansible/inventory.yml all -m ping

# Run a playbook against a specific group
ansible-playbook -i ansible/inventory.yml playbooks/your-playbook.yml -l k3s_cluster
```
