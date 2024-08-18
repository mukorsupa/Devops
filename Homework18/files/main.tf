provider "aws" {
  region = "us-west-2"  # Change to your desired region
}

resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-0a38c1c38a15fed74"  # Change to your desired AMI
  instance_type = "t2.micro"  # Change to your desired instance type

  tags = {
    Name = "example-instance-${count.index}"
  }
}

resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [all]
    ${aws_instance.example[0].public_ip}
    ${aws_instance.example[1].public_ip}
    EOT
  filename = "ansible/inventory"
}