resource "local_file" "rendered_file" {
  filename = "../../swarm/swarm01/vault/config.hcl"
  content = templatefile("../../swarm/swarm01/vault/config.hcl.tmpl", {
    endpoint = var.database["database.prod"].endpoint
    username = module.vault-database.user
    password = module.vault-database.password
    database = module.vault-database.database
  })
}
