module "network" {
  source = "../../modules/network"

  account = var.account
  env     = var.env

  cidr_block         = var.cidr_block
  availability_zones = var.availability_zones
}

module "bastion" {
  source = "../../modules/bastion"

  env     = var.env
  account = var.account

  ami_id              = var.bastion_ami_id
  ssh_public_key      = var.ssh_public_key
  allowed_ips         = var.allowed_ips
  aws_vpc-vpc-id      = module.network.aws_vpc-vpc-id
  public_subnet_id    = module.network.aws_subnet-public-ids[0]
  protected_subnet_id = module.network.aws_subnet-protected-ids[0]
  cidr_block          = var.cidr_block

  bastion_instance_type = var.bastion_instance_type

  other_side_tgw = var.other_side_tgw
}
