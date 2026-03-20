module "timer" {
  source            = "./modules/project"
  gitlab_project_id = 57345278
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "timer"
}

module "timer-dev-argocd" {
  source = "./modules/argocd/application-helm"

  application_name = "timer"
  environment      = "dev"
}

module "navan" {
  source            = "./modules/project"
  gitlab_project_id = 61487434
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "navan"
}

module "navan-api" {
  source            = "./modules/project"
  gitlab_project_id = 71696511
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "navan-api"
}


module "todo" {
  source            = "./modules/project"
  gitlab_project_id = 40519341
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "todo"
}

module "auth" {
  source            = "./modules/project"
  gitlab_project_id = 40847160
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "auth"
}

module "autodel" {
  source            = "./modules/project"
  gitlab_project_id = 77042100
  registry_server   = var.registry_server
  domain_name       = var.domain_name
  project_name      = "autodel"
}

module "autodel-argocd" {
  source = "./modules/argocd/application-helm"

  application_name = "autodel"
  environment      = "prod"
}

module "uptimekuma-argocd" {
  source = "./modules/argocd/application-manifests"

  application_name = "uptimekuma"
}

module "plex-argocd" {
  source = "./modules/argocd/application-manifests"

  application_name = "plex"
}

module "audiobookshelf-argocd" {
  source = "./modules/argocd/application-manifests"

  application_name = "audiobookshelf"
}
