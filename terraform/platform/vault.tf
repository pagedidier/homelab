resource "vault_auth_backend" "k3s_prod" {
  type = "kubernetes"
  path = "kubernetes/k3s_prod"
}

resource "vault_auth_backend" "k3s_dev" {
  type = "kubernetes"
  path = "kubernetes/k3s_dev"
}

resource "vault_mount" "projects" {
  path    = "projects"
  type    = "kv"
  options = { version = "2" }
  lifecycle {
    prevent_destroy = true
  }
}

resource "vault_kv_secret_backend_v2" "example" {
  mount        = vault_mount.projects.path
  max_versions = 5
}

module "timer-k8s-role" {
  source = "./modules/vault/role"

  environment_name          = "prod"
  project_name              = "timer"
  service_name              = "webapp"
  vault_k8s_service_account = module.timer.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path
}

module "todo-k8s-role-dev" {
  source = "./modules/vault/role"

  environment_name          = "dev"
  project_name              = "todo"
  service_name              = "api"
  vault_k8s_service_account = module.todo.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path

}

module "k8s-todo-webapp-role" {
  source = "./modules/vault/role"

  environment_name          = "dev"
  project_name              = "todo"
  service_name              = "webapp"
  vault_k8s_service_account = module.todo.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path

}


module "k8s-auth-api-role" {
  source = "./modules/vault/role"

  environment_name          = "dev"
  project_name              = "auth"
  service_name              = "api"
  vault_k8s_service_account = module.auth.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path

}

module "k8s-navan-server-role" {
  source = "./modules/vault/role"

  environment_name          = "dev"
  project_name              = "navan"
  service_name              = "server"
  vault_k8s_service_account = module.navan.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path
}

module "k8s-navan-api-role" {
  source = "./modules/vault/role"

  environment_name          = "dev"
  project_name              = "navan-api"
  service_name              = "api"
  vault_k8s_service_account = module.navan-api.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path
}

module "k8s-autodel-role" {
  source = "./modules/vault/role"

  environment_name          = "prod"
  project_name              = "autodel"
  service_name              = "api"
  vault_k8s_service_account = module.autodel.vault_k8s_service_account
  backend                   = vault_auth_backend.k3s_prod.path
}