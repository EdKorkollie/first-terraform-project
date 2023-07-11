# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "ed-devops-user"
}

# Stores the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "edward-devops-2023-terraform-remote-state"
    key     = "terraform.tfstate.devops2023"
    region  = "us-east-1"
    profile = "ed-devops-user"
  }
}
