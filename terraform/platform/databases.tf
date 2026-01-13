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

resource "vault_kv_secret_v2" "navan-dev" {
  mount = vault_mount.projects.path
  name  = "navan-api/dev/api"

  data_json = jsonencode({
    SPRING_DATASOURCE_USERNAME = module.navan-api-database.user
    SPRING_DATASOURCE_URL      = "jdbc:mysql://${var.database["database.prod"].endpoint}/${module.navan-api-database.database}?createDatabaseIfNotExist=true"
    SPRING_DATASOURCE_PASSWORD = module.navan-api-database.password
  })
}
