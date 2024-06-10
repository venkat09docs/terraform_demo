data "aws_ami" "webserver_ami" {
  most_recent      = true  
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.webserver_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [ aws_security_group.webserver-sg.id ]

  //user_data = <<-EOF
  //              EOF

  user_data = file(var.userdata_file)

  tags = var.instance_tags

}

resource "aws_security_group" "webserver-sg" {
  name        = "webserver_sg"
  description = "Allow SSH and HTTP inbound traffic and all outbound traffic"
  //vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.sg_ingress_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.sg_cidr_block
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webserver-sg"
  }
}

