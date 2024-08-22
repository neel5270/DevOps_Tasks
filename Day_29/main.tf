terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2_instance" {
  source        = "./modules/ec2_module"
  instance_type = var.instance_type
}

module "s3_bucket" {
  source      = "./modules/s3_module"
  bucket_neel = var.bucket_neel
}

output "ec2_public_ip" {
  value = module.ec2_instance.ec2_public_ip
}

output "s3_bucket_neel" {
  value = module.s3_bucket.s3_bucket_neel
}
