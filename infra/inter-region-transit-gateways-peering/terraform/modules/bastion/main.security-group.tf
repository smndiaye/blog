resource "aws_security_group" "bastion-sg" {
  name        = "${var.env}-${var.account}-bastion-sg"
  description = "bastion security group"
  vpc_id      = var.aws_vpc-vpc-id

  ingress {
    description = "allow ssh"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.allowed_ips.*.value
  }

  egress {
    description = "allow SSH outbound"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.cidr_block]
  }
}

resource "aws_security_group" "services-sg" {
  name        = "${var.env}-${var.account}-services-sg"
  description = "services security group"
  vpc_id      = var.aws_vpc-vpc-id

  ingress {
    description     = "allow ssh"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.bastion-sg.id]
  }

  ingress {
    description = "allow all traffic from other side"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.other_side_tgw.cidr_block]
  }

  egress {
    description = "allow all outbound"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
