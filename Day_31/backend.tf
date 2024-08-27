terraform {
  backend "s3" {
    bucket         = "neel-terraform-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "neel-dynamodb-table"
  }
}