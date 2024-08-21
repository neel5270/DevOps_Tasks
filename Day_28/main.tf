provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support=true
  enable_dns_hostnames=true

  tags = {
    Name = "utsavS-VPC"
  }
}

resource "aws_subnet" "utsavS-sub" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "utsavS-sub"
  }
}

resource "aws_subnet" "utsavS-sub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone       = "us-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "utsavS-sub1"
  }
}

resource "aws_internet_gateway" "utsav_internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "utsav_internet_gateway"
  }
}
resource "aws_route_table" "utsav_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.utsav_internet_gateway.id
  }

  tags = {
    Name = "utsav_route_table"
  }
}
resource "aws_route_table_association" "utsav_route_table_association" {
  subnet_id      = aws_subnet.utsavS-sub.id
  route_table_id = aws_route_table.utsav_route_table.id
}
 

# Security Groups
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "utsavS-Security"
  }
}


# EC2 Instance
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.utsavS-sub.id
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "UtsavS-WebServer"
  }
}



resource "aws_db_subnet_group" "utsav_db_subnet_group" {
  name       = "utsav_db_subnet_group"
  subnet_ids = [aws_subnet.utsavS-sub.id,aws_subnet.utsavS-sub1.id]

  tags = {
    Name = "utsav_db_subnet_group"
  }
}
resource "aws_db_instance" "utsav_mysql_db" {
  identifier             = "utsav-mysql-db"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "mydbUS"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.utsav_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  publicly_accessible    = true
  skip_final_snapshot  = false
  final_snapshot_identifier = "i-skip-snapshot"
  tags = {
    Name = "utsav_mysql_db"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "static_assets" {
  bucket = "my-static-assets-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
