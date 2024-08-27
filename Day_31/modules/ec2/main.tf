resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = [var.web_sg_id]

  tags = {
    Name = "utsav-WebServe"
  }
}

resource "aws_eip" "web_eip" {
  instance   = aws_instance.web.id
}
