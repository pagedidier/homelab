# resource "vault_mount" "infrastructure" {
#   path        = "infrastructure"
#   type        = "kv"
#   options     = { version = "2" }
#   description = "Secrets for infra"
# }
#
# module "todo-k8s-role" {
#   source = "./modules/vault/role"
#
#   environment_name = "prod"
#   project_name     = "todo"
#   service_name     = "api"
# }
#
# module "todo-k8s-role-dev" {
#   source = "./modules/vault/role"
#
#   environment_name = "dev"
#   project_name     = "todo"
#   service_name     = "api"
# }
#
# module "k8s-todo-webapp-role" {
#   source = "./modules/vault/role"
#
#   environment_name = "dev"
#   project_name     = "todo"
#   service_name     = "webapp"
# }
#
# module "k8s-auth-api-role" {
#   source = "./modules/vault/role"
#
#   environment_name = "dev"
#   project_name     = "auth"
#   service_name     = "api"
# }
#
# module "k8s-navan-server-role" {
#   source = "./modules/vault/role"
#
#   environment_name = "dev"
#   project_name     = "navan"
#   service_name     = "server"
# }