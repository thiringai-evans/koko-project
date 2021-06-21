terraform {
 backend "s3" {
 encrypt = true
 bucket = "thiringai-terraform"
 region = "us-east-1"
 key = "terraform/terraform.tfstate"
 }
}