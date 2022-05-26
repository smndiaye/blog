variable "account" {
  type = string
}

variable "env" {
  type = string
}

variable "availability_zones" {
  type = set(string)
}

variable "cidr_block" {
  type = string
}
