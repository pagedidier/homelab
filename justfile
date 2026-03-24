# justfile

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set dotenv-load := true

projects := "infra platform"
venv := ".venv"
python := "python3"
script := "role_exporter.py"
script_dir := "terraform/platform"

venv:
    {{ python }} -m venv {{ venv }}

install: venv
    {{ venv }}/bin/pip install --upgrade pip
    {{ venv }}/bin/pip install pyyaml

_tf_cd project cmd:
    @if [[ ! " {{ projects }} " =~ " {{ project }} " ]]; then \
        echo "Unknown project: {{ project }}"; \
        exit 1; \
    fi
    cd terraform/{{ project }} && {{ cmd }}

validate project:
    just _tf_cd {{ project }} "terraform validate"

init project:
    just _tf_cd {{ project }} "terraform init -backend-config=backend-config.json"

generate_inventory_infra:
    just init infra
    cd terraform/infra && terraform output -raw inventory > ../../ansible/inventory/inventory.yaml

generate_inventory_platform: generate_inventory_infra install
    cd {{ script_dir }} && ../../{{ venv }}/bin/python {{ script }} > inventory.yaml
