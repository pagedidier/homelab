resource "mysql_database" "database" {
  name = var.database_name
}

resource "random_password" "password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "mysql_user" "user" {
  user               = var.database_name
  host               = "%"
  plaintext_password = random_password.password.result
}

resource "mysql_grant" "grant" {
  user       = mysql_user.user.user
  host       = mysql_user.user.host
  database   = mysql_database.database.name
  privileges = ["ALL"]
}