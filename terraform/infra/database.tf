resource "mysql_database" "vault" {
  name = "vault"
}

resource "mysql_user" "vault" {
  user               = "vault"
  host               = "%"
  plaintext_password = "password"
}

resource "mysql_grant" "vault" {
  user     = mysql_user.vault.user
  host     = mysql_user.vault.host
  database = mysql_database.vault.name
  privileges = ["ALL"]
}