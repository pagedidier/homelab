terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.4.0"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
  }
}

data "vault_policy_document" "repo-policy-document"{
  rule {
    capabilities = ["read"]
    path         = "repos/data/${var.repo_name}/*"
  }

  dynamic "rule" {
    for_each = var.extra_policies
    content {
      path         = rule.value.path
      capabilities = rule.value.capabilites
    }
  }
}

resource "vault_policy" "repo-policy" {
  name   = "repo-${var.repo_name}-read"
  policy = data.vault_policy_document.repo-policy-document.hcl
}



resource "vault_approle_auth_backend_role" "repo_role" {
  backend        = var.auth_path
  role_name      = "${var.repo_name}-role"

  token_policies = [vault_policy.repo-policy.name]
}

resource "vault_approle_auth_backend_role_secret_id" "repo_secret_id" {
  backend   = var.auth_path
  role_name = vault_approle_auth_backend_role.repo_role.role_name
}

output "role_id" {
  value = vault_approle_auth_backend_role.repo_role.role_id
}

output "secret_id" {
  value = vault_approle_auth_backend_role_secret_id.repo_secret_id.secret_id
}

data "gitlab_project" "project" {
  path_with_namespace = "${var.gitlab_group}/${var.repo_name}"
}

resource "gitlab_project_variable" "vault_addr" {
  project   = data.gitlab_project.project.id
  key       = "VAULT_ADDR"
  value     = var.vault_addr
  protected = false
}

resource "gitlab_project_variable" "vault_role_id" {
  project   = data.gitlab_project.project.id
  key       = "VAULT_ROLE_ID"
  value     = vault_approle_auth_backend_role.repo_role.role_id
  protected = false
}

resource "gitlab_project_variable" "vault_secret_id" {
  project   = data.gitlab_project.project.id
  key       = "VAULT_SECRET_ID"
  value     = vault_approle_auth_backend_role_secret_id.repo_secret_id.secret_id
  protected = false
}



