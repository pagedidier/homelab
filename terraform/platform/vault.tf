module "timer-k8s-role" {
  source = "./modules/vault/role"

  environment_name = "prod"
  project_name     = "timer"
  service_name     = "webapp"
  vault_k8s_service_account = module.timer.vault_k8s_service_account
}

module "todo-k8s-role-dev" {
  source = "./modules/vault/role"

  environment_name = "dev"
  project_name     = "todo"
  service_name     = "api"
  vault_k8s_service_account = module.todo.vault_k8s_service_account

}

module "k8s-todo-webapp-role" {
  source = "./modules/vault/role"

  environment_name = "dev"
  project_name     = "todo"
  service_name     = "webapp"
  vault_k8s_service_account = module.todo.vault_k8s_service_account

}


module "k8s-auth-api-role" {
  source = "./modules/vault/role"

  environment_name = "dev"
  project_name     = "auth"
  service_name     = "api"
  vault_k8s_service_account = module.auth.vault_k8s_service_account

}

module "k8s-navan-server-role" {
  source = "./modules/vault/role"

  environment_name = "dev"
  project_name     = "navan"
  service_name     = "server"
  vault_k8s_service_account = module.navan.vault_k8s_service_account

}