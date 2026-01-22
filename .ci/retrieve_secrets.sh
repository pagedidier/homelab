#!/bin/sh
REPO_NAME="$1"
VAULT_BASE_PATH="repos/$REPO_NAME"

# Output directory (current directory)
OUTPUT_DIR="."
mkdir -p "$OUTPUT_DIR"

process_path() {
    local path="$1"

    # Try to list items (directories)
    items=$(vault kv list -format=json "$path" 2>/dev/null | jq -r '.[]?' || true)

    if [ -z "$items" ]; then
        # Not a directory → try to read as a secret
        secret_json=$(vault kv get -format=json "$path" 2>/dev/null || true)

        if [ -n "$secret_json" ]; then
            # Extract ONLY the secret data as JSON
            secret_data=$(echo "$secret_json" | jq '.data.data')

            # Skip empty secrets
            if [ "$secret_data" != "null" ]; then
                # Preserve directory structure
                relative_path="${path#repos/$REPO_NAME/}"
                file_path="$OUTPUT_DIR/$relative_path"

                mkdir -p "$(dirname "$file_path")"
                echo "$secret_data" | jq '.' > "$file_path"

                echo "Created file: $file_path"
            fi
        fi
    else
        # Directory → recurse
        for item in $items; do
            clean_item="${item%/}"
            process_path "$path/$clean_item"
        done
    fi
}

process_path "$VAULT_BASE_PATH"
