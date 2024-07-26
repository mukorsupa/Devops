resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "Allow specified ports from anywhere"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.list_of_open_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.vpc_id
}

resource "aws_instance" "nginx_instance" {
  ami           = "ami-0427090fd1714168b" 
  instance_type = "t2.micro"
  subnet_id     = element(data.aws_subnet_ids.subnet_ids.ids, 0)
  security_groups = [aws_security_group.nginx_sg.name]

  user_data = file("ec2_userdata.sh")

  tags = {
    Name = "NginxInstance"
  }
}
