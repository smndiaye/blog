variable "env" {
  type = string
}

variable "account" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "allowed_ips" {
  type = list(object({
    type  = string
    value = string
    })
  )
}

variable "public_subnet_id" {
  type = string
}

variable "protected_subnet_id" {
  type = string
}

variable "aws_vpc-vpc-id" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "other_side_tgw" {
  type = object({
    cidr_block = string
  })
}
