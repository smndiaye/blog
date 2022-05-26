locals {
  azs_count = length(local.azs_list)
  new_bits  = 4
}

resource "aws_subnet" "public" {
  for_each = local.azs_set

  availability_zone = each.value
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, local.new_bits, index(local.azs_list, each.value) + (local.azs_count * 0))
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-public-${substr(each.value, -1, -1)}"
  }
}

resource "aws_subnet" "protected" {
  for_each = local.azs_set

  availability_zone = each.value
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, local.new_bits, index(local.azs_list, each.value) + (local.azs_count * 1))
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-protected-${substr(each.value, -1, -1)}"
  }
}
