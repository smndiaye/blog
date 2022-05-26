resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  associate_public_ip_address = true
}

resource "aws_key_pair" "bastion" {
  key_name   = "${var.env}-${var.account}-bastion"
  public_key = var.ssh_public_key
}

resource "aws_eip_association" "associate_eip_bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion.id
}

resource "aws_eip" "bastion" {
  vpc = true

  tags = {
    Name = "${var.env}-bastion-eip"
  }
}

resource "aws_instance" "services" {
  ami                         = var.ami_id
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = var.protected_subnet_id
  vpc_security_group_ids      = [aws_security_group.services-sg.id]
  associate_public_ip_address = false
}
