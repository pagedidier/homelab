output "password" {
  value = random_password.password.result
  sensitive = true
}
output "database" {
  value = mysql_database.database.name
}

output "user" {
  value = mysql_user.user.user
}