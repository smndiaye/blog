variable "account" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "availability_zones" {
  type = set(string)
}

variable "allowed_ips" {
  type = list(object({
    type  = string
    value = string
    })
  )
}

variable "ssh_public_key" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "bastion_ami_id" {
  type = string
}

variable "other_side_tgw" {
  type = object({
    id                    = string
    region                = string
    account_id            = string
    cidr_block            = string
    peering_attachment_id = string
  })
}
