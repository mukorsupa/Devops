provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "your-unique-bucket-name"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}