variable "zone_fqdn" {
  type = string
}
variable "dns_source" {
  type = string
}
variable "target" {
  type = string
}
variable "port" {
  type = number
}
variable "ttl" {
  type = number
  default = 300
}
variable "priority" {
  type = number
  default = 10
}
variable "weight" {
  type = number
  default = 0
}