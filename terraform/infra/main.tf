locals {
  environments = ["dev","staging","prod"]
}

data "infomaniak_zone" "twop" {
  fqdn = "twop.ch"
}
data "infomaniak_zone" "nohanbudry" {
  fqdn = "nohanbudry.com"
}