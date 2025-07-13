#!/bin/bash

# Files
TF_OUTPUT_FILE="tf_output.json"
INVENTORY_FILE="inventory/hosts.yaml"
OUTPUT_FILE="inventory/inventory.yaml"

terraform -chdir=../terraform/infra output  -json inventory > $TF_OUTPUT_FILE


# Create YAML from Terraform output
TMP_YAML=$(mktemp)

jq -r '
  to_entries | map(
    {
      key: .key,
      value: {
        "hosts": (
          .value | map({
            (.hostname): (
              {
                ansible_host: .ip,
                ansible_user: .username
              }
              + (if has("port") then { ansible_port: .port } else {} end)
            )
          }) | add
        )
      }
    }
  ) | { all: { children: (map({ (.key): .value }) | add) } }
' "$TF_OUTPUT_FILE" | yq -P > "$TMP_YAML"

# Merge with original inventory
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' "$INVENTORY_FILE" "$TMP_YAML" > "$OUTPUT_FILE"

rm "$TMP_YAML"
rm  "$TF_OUTPUT_FILE"
