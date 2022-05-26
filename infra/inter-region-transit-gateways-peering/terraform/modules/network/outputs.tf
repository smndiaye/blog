output "aws_vpc-vpc-id" {
  value = aws_vpc.vpc.id
}

output "aws_subnet-protected-ids" {
  value = values(aws_subnet.protected).*.id
}

output "aws_subnet-public-ids" {
  value = values(aws_subnet.public).*.id
}

output "aws_route_table-protected-id" {
  value = aws_route_table.protected.id
}
