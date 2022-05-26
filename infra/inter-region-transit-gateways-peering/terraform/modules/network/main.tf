locals {
  azs_set    = var.availability_zones
  azs_list   = tolist(local.azs_set)
  primary_az = local.azs_list[0]
}
