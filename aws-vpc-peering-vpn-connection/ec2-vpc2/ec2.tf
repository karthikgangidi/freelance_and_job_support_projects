resource "aws_security_group" "sec-group-vpc-ssh-icmp-2" {
  name        = "VPC-B-SG"
  description = "Allow SSH and ICMP traffic"
  vpc_id      = var.vpc_B_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC-B-SG"
  }
}


resource "aws_instance" "VPC-B-private-instance" {
  ami                         = var.image_id_vpc_B
  instance_type               = var.instance_type
  subnet_id                   = var.vpc_B_private_subnet 
  vpc_security_group_ids     = [ "${aws_security_group.sec-group-vpc-ssh-icmp-2.id}" ]
  key_name                    = var.key_name_in_west1

  tags = {
    Name = "vpc-B-private-instanace"
  }
}