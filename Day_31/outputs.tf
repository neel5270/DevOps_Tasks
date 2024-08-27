output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "web_ec2_ids" {
  value = module.ec2.web_ec2_ids
}

output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}