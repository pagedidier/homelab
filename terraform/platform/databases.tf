module "vault-database" {
  source = "./modules/database"

  database_name = "vault"

}
