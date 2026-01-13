#!/usr/bin/env bash
set -euo pipefail

ANSIBLE_ROOT="../../ansible"
INVENTORY="$ANSIBLE_ROOT/inventory/inventory.yaml"
PLAYBOOK_DIR="$ANSIBLE_ROOT/playbooks/servers"

declare -A HOST_IP
declare -A GROUP_HOSTS
declare -A ROLE_GROUPS

# --- Recursively parse groups ---
parse_group() {
    local group="$1"
    local path="$2"

    # Get hosts (empty if none)
    local hosts
    hosts=$(yq -r ".all.children${path}.hosts // {} | keys[]" "$INVENTORY" 2>/dev/null || true)
    for host in $hosts; do
        local ip
        ip=$(yq -r "
            .all.children${path}.hosts.\"$host\".hostname //
            .all.children${path}.hosts.\"$host\".ansible_host //
            \"$host\"
        " "$INVENTORY")
        HOST_IP["$host"]="$ip"
        GROUP_HOSTS["$group"]+="$host "
    done

    # Get children (empty if none)
    local children
    children=$(yq -r ".all.children${path}.children // {} | keys[]" "$INVENTORY" 2>/dev/null || true)
    for child in $children; do
        parse_group "$child" "${path}.children.\"$child\""
        GROUP_HOSTS["$group"]+=" ${GROUP_HOSTS[$child]-}"
    done

    # Deduplicate
    read -r -a uniq <<<"$(printf "%s\n" ${GROUP_HOSTS[$group]-} | awk '!seen[$0]++')"
    GROUP_HOSTS["$group"]="${uniq[*]-}"
}

collect_inventory() {
    local top
    top=$(yq -r '.all.children | keys[]' "$INVENTORY")
    for group in $top; do
        parse_group "$group" ".\"$group\""
    done
}

collect_roles() {
    local file idx
    for file in "$PLAYBOOK_DIR"/*.yaml; do
        idx=0
        while true; do
            # Extract hosts: string or array
            local hosts
            hosts=$(yq -r ".[$idx].hosts // empty" "$file" 2>/dev/null || true)
            [[ -z "$hosts" ]] && break

            # Normalize hosts to a space-separated list
            local host_list
            host_list=""
            while IFS= read -r h; do
                host_list+="$h "
            done < <(yq -r ".[$idx].hosts | if type == \"array\" then .[] else . end" "$file")

            # Extract roles
            local roles
            roles=$(yq -r ".[$idx].roles // [] | .[] | .role // ." "$file" 2>/dev/null || true)
            # Map role → group
            local role
            for role in $roles; do
                ROLE_GROUPS["$role"]+="$host_list"
            done

            ((idx++))
        done
    done
}

build_role_ips() {
    echo "roles:"
    for role in "${!ROLE_GROUPS[@]}"; do
        echo "  $role:"
        for group in ${ROLE_GROUPS[$role]-}; do
            for host in ${GROUP_HOSTS[$group]-}; do
                local ip="${HOST_IP[$host]-}"
                [[ -n "$ip" ]] && echo "    - $ip"
            done
        done
    done
}

collect_inventory
collect_roles
build_role_ips
