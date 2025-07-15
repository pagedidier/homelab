locals {
  environments = ["dev","staging","prod"]
}

data "infomaniak_zone" "twop" {
  fqdn = "twop.ch"
}