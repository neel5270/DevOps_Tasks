resource "aws_security_group" "allow_ssh" {
  name_prefix = "terraform-example-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-000a81e3bab21747d"  # Example AMI
  instance_type = var.instance_type

  tags = {
    Name = "WebServer"
  }

  security_groups = [aws_security_group.allow_ssh.name]
}

output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}
