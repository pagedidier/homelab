module "timer" {
  source = "./modules/project"

  for_each = toset(local.environments)

  environment_name = each.key
  project_id = 57345278
  registry_server = var.registry_server
  domain_name      = var.domain_name
}
