#!/bin/sh

REPO_NAME=$1
VAULT_BASE_PATH="repos/$REPO_NAME"

# Output directory for secret files
OUTPUT_DIR="."
mkdir -p "$OUTPUT_DIR"

# Function to recursively process a Vault path
process_path() {
    local path="$1"

    # Try to list items at this path (folders or secrets)
    items=$(vault kv list -format=json "$path" 2>/dev/null | jq -r '.[]?' || true)

    if [ -z "$items" ]; then
        # Might be a secret directly, check if it exists
        secret_json=$(vault kv get -format=json "$path" 2>/dev/null || true)

        if [ -n "$secret_json" ]; then
            # Extract all keys and values
            value=$(echo "$secret_json" | jq -r '.data.data | to_entries[] | "\(.key)=\(.value)"' 2>/dev/null || true)
            if [ -n "$value" ]; then
                # Preserve directory structure under rules
                relative_path="${path#repos/homelab/}"   # remove base Vault path
                file_path="$OUTPUT_DIR/$relative_path"
                mkdir -p "$(dirname "$file_path")"
                echo "$value" > "$file_path"
                echo "Created file: $file_path"
            fi
        fi
    else
        # Iterate over items
        for item in $items; do
            # Remove trailing slash from folders
            clean_item="${item%/}"
            process_path "$path/$clean_item"
        done
    fi
}

# Start recursion
process_path "$VAULT_BASE_PATH"