provider "aws" {
  region = var.region
}


resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "my-ec2-keypair"  # Replace with your desired key pair name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name      = aws_key_pair.ec2_key_pair.key_name
  
  tags = {
    Name = "${terraform.workspace}-utsav-ec2"
  }

    connection {
      type        = "ssh"
      user        = "ubuntu"  
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
    ]
  }

}
