module "timer" {
  source = "./modules/project"
  project_id = 57345278
  registry_server = var.registry_server
  domain_name      = var.domain_name
  project_name = "timer"
}
