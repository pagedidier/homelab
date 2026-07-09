module "vault-database" {
  source = "./modules/database"

  database_name = "vault"
}

module "todo-database" {
  source = "./modules/database"

  database_name = "todo"
}

module "navan-api-database" {
  source = "./modules/database"

  database_name = "navan-api"
}

module "cheaps-api-database" {
  source = "./modules/database"

  database_name = "cheaps-api"
}

resource "vault_kv_secret_v2" "cheaps-prod" {
  mount = vault_mount.projects.path
  name  = "cheaps-api/prod/api"

  data_json = jsonencode({
    DATABASE_URL = "mysql://${module.cheaps-api-database.user}:${module.cheaps-api-database.password}@${var.database["database.prod"].endpoint}/${module.cheaps-api-database.database}"
  })
}

module "cheap-api-database" {
  source = "./modules/database"

  database_name = "cheap"
}

resource "vault_kv_secret_v2" "cheap-prod-api-database" {
  mount = vault_mount.projects.path
  name  = "cheap/prod/api"

  data_json = jsonencode({
    DATABASE_URL = "mysql://${module.cheap-api-database.user}:${module.cheap-api-database.password}@${var.database["database.prod"].endpoint}/${module.cheap-api-database.database}"
  })
}

resource "vault_kv_secret_v2" "navan-dev" {
  mount = vault_mount.projects.path
  name  = "navan-api/dev/api"

  data_json = jsonencode({
    SPRING_DATASOURCE_USERNAME = module.navan-api-database.user
    SPRING_DATASOURCE_URL      = "jdbc:mysql://${var.database["database.prod"].endpoint}/${module.navan-api-database.database}?createDatabaseIfNotExist=true"
    SPRING_DATASOURCE_PASSWORD = module.navan-api-database.password
  })
}
