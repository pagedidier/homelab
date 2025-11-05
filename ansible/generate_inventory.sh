#!/bin/bash
set -euo pipefail

# Files
TF_OUTPUT_FILE="tf_output.json"
INVENTORY_FILE="inventory/hosts.yaml"
OUTPUT_FILE="inventory/inventory.yaml"

# Get Terraform output
terraform -chdir=../terraform/infra output -json inventory > "$TF_OUTPUT_FILE"

# Create temporary YAML
TMP_YAML=$(mktemp)

jq -r '
  # Convert a host definition into an Ansible-compatible mapping
  def host_entry:
    {
      (.hostname): (
        {
          ansible_host: .ip,
          ansible_user: .username
        }
        + (if has("port") then { ansible_port: .port } else {} end)
      )
    };

  # Determine if a group contains nested children (e.g. swarm_dev -> managers/workers)
  def group_entry:
    if (map(keys) | add | unique | any(. as $k | $k != "hostname" and $k != "ip" and $k != "username" and $k != "id" and $k != "port")) then
      {
        children: (
          map(
            to_entries[]
            | select(.key != "hostname" and .key != "ip" and .key != "username" and .key != "id" and .key != "port")
            | { (.key): { hosts: (.value | map(host_entry) | add) } }
          )
          | add
        )
      }
    else
      { hosts: (map(host_entry) | add) }
    end;

  # Build the top-level YAML structure
  to_entries
  | { all: { children: (map({ (.key): (.value | group_entry) }) | add) } }
' "$TF_OUTPUT_FILE" | yq -P > "$TMP_YAML"

# Merge with static inventory
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' "$INVENTORY_FILE" "$TMP_YAML" > "$OUTPUT_FILE"

# Cleanup
rm "$TMP_YAML" "$TF_OUTPUT_FILE"
