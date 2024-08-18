resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf/jji696AU15LpVbFry+Jfc9DlkpioaGKUsOHqJ4+ZOALri2zDGuEZGGs7wrlP04+J3jwTrR6FeSk9JUsbSy2ggkQd5ciBfiWO5v+06/zjN60qkvbVl9kKQNqQUSktL93vTlQScD2wv5QaaZw0VuY52rdTVBbvEZSKkSld3paQiwX8ahVRNQUEJiXZZdIhEw3VhwR7rUt7zYiNDsH4Pmdql0TLl2O861kfiLes2D0G9uW6pZ1Dm3BcIlL07EoWYScujIAqMqmgJ5tSU0KveAqYLTfd1hthYHnTs9qbLwJTpco812ItDHjW5W0HM7LAgEx+lhhKpT5AN6DhBP467hB Gitlab SSH" 
}

resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_master" {
  ami                         = "ami-0c55b159cbfafe1f0" # Change to your preferred AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  associate_public_ip_address = true

  tags = {
    Name = "jenkins-master"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf/jji696AU15LpVbFry+Jfc9DlkpioaGKUsOHqJ4+ZOALri2zDGuEZGGs7wrlP04+J3jwTrR6FeSk9JUsbSy2ggkQd5ciBfiWO5v+06/zjN60qkvbVl9kKQNqQUSktL93vTlQScD2wv5QaaZw0VuY52rdTVBbvEZSKkSld3paQiwX8ahVRNQUEJiXZZdIhEw3VhwR7rUt7zYiNDsH4Pmdql0TLl2O861kfiLes2D0G9uW6pZ1Dm3BcIlL07EoWYScujIAqMqmgJ5tSU0KveAqYLTfd1hthYHnTs9qbLwJTpco812ItDHjW5W0HM7LAgEx+lhhKpT5AN6DhBP467hB Gitlab SSH" >> /home/ec2-user/.ssh/authorized_keys
              EOF
}

resource "aws_instance" "jenkins_worker" {
  ami                         = "ami-0c55b159cbfafe1f0" # Change to your preferred AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  associate_public_ip_address = false

  tags = {
    Name = "jenkins-worker"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "your-public-key" >> /home/ec2-user/.ssh/authorized_keys
              EOF
}