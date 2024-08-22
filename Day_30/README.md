### **Project: Advanced Terraform with Provisioners, Modules, and Workspaces**

#### **Project Objective:**

This project is designed to evaluate participants' understanding of Terraform provisioners, modules, and workspaces. The project involves deploying a basic infrastructure on AWS using Terraform modules, executing remote commands on the provisioned resources using provisioners, and managing multiple environments using Terraform workspaces. All resources should be within the AWS Free Tier limits.

#### **Project Overview:**

Participants will create a Terraform configuration that deploys an EC2 instance and an S3 bucket using a custom Terraform module. The project will also require the use of Terraform provisioners to execute scripts on the EC2 instance. Finally, participants will manage separate environments (e.g., dev and prod) using Terraform workspaces.

#### **Key Tasks:**

1. **Module Development**:  
   * **Module Setup**: Create a directory for the module (e.g., `modules/aws_infrastructure`).  
   * **Resource Definitions**: Define the resources for an EC2 instance and an S3 bucket within the module.  
   * **Variable Inputs**: Define input variables for instance type, AMI ID, key pair name, and S3 bucket name.  
   * **Outputs**: Define outputs for the EC2 instance's public IP and the S3 bucket's ARN.  

    ![](./media/7.png)

2. **Main Terraform Configuration**:  
   * **Main Config Setup**: In the root directory, create a Terraform configuration that calls the custom module.  
   * **Backend Configuration**: Configure Terraform to use local state storage for simplicity (optional for Free Tier compliance).  

    ```tf
    terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"
    }
    provider "aws" {
    region  = var.region
    profile = var.aws_profile
    }

    module "ec2" {
    source        = "./modules/ec2"
    ami           = "ami-********"
    instance_type = "t2.micro"
    region        = "us-****-*"
    }

    module "s3" {
    source = "./modules/s3"
    region = "us-****-*"
    }
    ```

3. **Provisioner Implementation**:  
   * **Remote Execution**: Use the `remote-exec` provisioner to SSH into the EC2 instance and execute a script that installs Apache.  

    ```tf
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
    ```

   * **Local Execution**: Use the `local-exec` provisioner to print a confirmation message on the local machine after successful deployment.  

    ```tf
    provider "aws" {
    region = var.region
    }

    # S3 Bucket
    resource "aws_s3_bucket" "app_data" {
    bucket = "${terraform.workspace}-utsav-bucket"

    tags = {
        Name = "${terraform.workspace}-utsav-bucket" 
    }

    provisioner "local-exec" {
        command = "echo 'S3 bucket Created'"
    }
    }
    ```

4. **Workspace Management**:  
   * **Workspace Creation**: Create Terraform workspaces for `stag` and `prod`.  
   * **Environment-Specific Configurations**: Customize the EC2 instance tags and S3 bucket names for each workspace to differentiate between environments.  
   * **Workspace Deployment**: Deploy the infrastructure separately in the `stag` and `prod` workspaces.  

    ![](./media/2.png)

5. **Validation and Testing**:  
   * **Apache Installation Verification**: After the deployment, verify that Apache is installed and running on the EC2 instance by accessing the public IP address in a web browser.  
   * **Workspace Separation**: Confirm that each workspace has its own isolated infrastructure and state files.  
   * **Provisioner Logs**: Review the output from the `local-exec` provisioner to ensure it indicates successful deployment.  

    ![](./media/1.png)
    ![](./media/3.png)
    ![](./media/4.png)
    ![](./media/5.png)
    ![](./media/6.png)

6. **Resource Cleanup**:  
   * **Destroy Resources**: Use `terraform destroy` to remove the resources in both workspaces.  
   * **Workspace Management**: Confirm that the resources are destroyed separately in each workspace and that the state files are updated accordingly. 

   ![](./media/9.png)
   ![](./media/10.png)

