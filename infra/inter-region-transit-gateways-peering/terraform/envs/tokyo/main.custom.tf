# Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "TGW to be peered with other AWS account"

  tags = {
    Name = "${var.env}-transit-gateway-${var.region}"
  }
}

# VPC attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "attach-tgw-to-vpc" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  vpc_id     = module.network.aws_vpc-vpc-id
  subnet_ids = module.network.aws_subnet-protected-ids

  transit_gateway_default_route_table_propagation = false
}

### TODO apply when other side TGW ready
## Create the Peering attachment
#resource "aws_ec2_transit_gateway_peering_attachment" "request-peering" {
#  peer_account_id         = var.other_side_tgw.account_id
#  peer_region             = var.other_side_tgw.region
#  peer_transit_gateway_id = var.other_side_tgw.id
#  transit_gateway_id      = aws_ec2_transit_gateway.tgw.id
#}
#
### TODO apply when other side peering ready
## VPC protected subnet route to the other AWS account protected subnet
#resource "aws_route" "out-of-protected-subnet" {
#  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
#
#  route_table_id         = module.network.aws_route_table-protected-id
#  destination_cidr_block = var.other_side_tgw.cidr_block
#}
#
## Route to the other side: forward other side route to the peering attachment
#resource "aws_ec2_transit_gateway_route" "tgw-route-other-pf" {
#  destination_cidr_block         = var.other_side_tgw.cidr_block
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.request-peering.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw.association_default_route_table_id
#}
#
## Route to this side: forward this side route to the VPC itself
#resource "aws_ec2_transit_gateway_route" "tgw-route-for-iot-pf" {
#  destination_cidr_block         = var.cidr_block
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attach-tgw-to-vpc.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw.association_default_route_table_id
#}
