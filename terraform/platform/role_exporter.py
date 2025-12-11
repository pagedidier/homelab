import yaml
from pathlib import Path
from collections import defaultdict

ANSIBLE_ROOT = Path("../../ansible")
INVENTORY = ANSIBLE_ROOT / "inventory" / "inventory.yaml"
PLAYBOOK_DIR = ANSIBLE_ROOT / "playbooks" / "servers"

def load_yaml(file):
    with open(file, "r") as f:
        return yaml.safe_load(f)

def parse_inventory_group(name, data, hosts_by_group, host_ip):
    """
    Recursively parse an inventory group and return the list of hosts
    belonging to this group (including hosts from nested children).
    """

    collected_hosts = []

    # --- Process hosts under this group ---
    hosts = data.get("hosts", {}) or {}
    if isinstance(hosts, dict):
        for host, params in hosts.items():
            collected_hosts.append(host)
            if isinstance(params, dict):
                # Save IP/hostname resolving
                host_ip[host] = params.get("hostname") or params.get("ansible_host") or host

    # --- Process children recursively ---
    children = data.get("children", {}) or {}
    if isinstance(children, dict):
        for child_name, child_data in children.items():
            child_hosts = parse_inventory_group(child_name, child_data, hosts_by_group, host_ip)
            collected_hosts.extend(child_hosts)

    # Remove duplicates but preserve order
    collected_hosts = list(dict.fromkeys(collected_hosts))

    # Register the aggregated host list for this group
    hosts_by_group[name] = collected_hosts

    return collected_hosts


def collect_inventory_hosts():
    inv = load_yaml(INVENTORY)

    hosts_by_group = {}
    host_ip = {}

    top = inv.get("all", {})
    top_children = top.get("children", {}) or {}

    # Recurse through all first-level children under 'all'
    for group_name, group_data in top_children.items():
        parse_inventory_group(group_name, group_data, hosts_by_group, host_ip)

    return hosts_by_group, host_ip

def collect_roles_from_playbooks():
    role_to_groups = defaultdict(set)

    for playbook_file in PLAYBOOK_DIR.glob("*.yaml"):
        playbook = load_yaml(playbook_file)
        for block in playbook:
            group = block.get("hosts")
            if not group:
                continue

            for role in block.get("roles", []):
                if isinstance(role, dict):
                    role_name = role.get("role")
                else:
                    role_name = role
                if role_name:
                    role_to_groups[role_name].add(group)

    return role_to_groups

def build_role_to_ip_map():
    hosts_by_group, host_ip = collect_inventory_hosts()
    roles_to_groups = collect_roles_from_playbooks()
    role_to_ips = defaultdict(list)

    for role, groups in roles_to_groups.items():
        for group in groups:
            if group in hosts_by_group:
                hosts = hosts_by_group[group]
            else:
                hosts = [group] if group in host_ip else []

            for host in hosts:
                if host in host_ip:
                    role_to_ips[role].append(host_ip[host])

    return role_to_ips


if __name__ == "__main__":
    mapping = build_role_to_ip_map()
    output = {"roles": {role: ips for role, ips in mapping.items()}}
    print(yaml.dump(output, sort_keys=False))