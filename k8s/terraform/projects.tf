module "timer" {
  source = "./modules/project"
  gitlab_project_id = 57345278
  registry_server = var.registry_server
  domain_name      = var.domain_name
  project_name = "timer"
}
#
# module "todo" {
#   source = "./modules/project"
#   project_id = 40519341
#   registry_server = var.registry_server
#   domain_name      = var.domain_name
#   project_name = "todo"
# }
#
# module "auth" {
#   source = "./modules/project"
#   project_id = 40847160
#   registry_server = var.registry_server
#   domain_name      = var.domain_name
#   project_name = "auth"
# }
#
# module "navan" {
#   source = "./modules/project"
#   project_id = 61487434
#   registry_server = var.registry_server
#   domain_name      = var.domain_name
#   project_name = "navan"
# }
#
# */