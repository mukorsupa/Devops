provider "aws" {
  region                  = "eu-north-1"
  shared_credentials_files = ["~/.aws/credentials"]
}


module "vpc" {
  source = "../vpc"
}

module "nginx_server" {
  source = "../aws_terraform_module"  # Path to your module

  vpc_id            = module.vpc.vpc_id
  list_of_open_ports = [80, 443]      # List of ports to open
}

output "instance_ip" {
  value = module.nginx_server.instance_ip
}
