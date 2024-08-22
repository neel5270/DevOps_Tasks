resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_neel  // Ensure the bucket name is unique

  tags = {
    Name = "MyAppData"
  }
}

output "s3_bucket_neel" {
  value = aws_s3_bucket.bucket.id
}
