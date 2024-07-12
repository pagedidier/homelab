terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
  }
}

module "k8s-project" {
  source = "../k8s/project"
  domain_name = var.domain_name
  gitlab_project_id = var.project_id
  project_name = var.project_name
  registry_server = var.registry_server
}


