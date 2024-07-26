terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops-2"
    key    = "terraform17/mukorsupa1@gmail.com/terraform.tfstate"
    region = "eu-north-1"
  }
}
