provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

module "k8s-environment-dev" {

  for_each = toset(local.environments)
  source = "./modules/k8s/environment"
  environment_name = each.key
  gitlab_group = 6498509
  domain_name = var.domain_name
}