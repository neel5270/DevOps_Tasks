### **Project: Advanced Terraform with Modules, Functions, State Locks, Remote State Management, and Variable Configuration**

#### **Project Objective:**

This project will test your skills in using Terraform modules, functions, variables, state locks, and remote state management. The project requires deploying infrastructure on AWS using a custom Terraform module and managing the state remotely in an S3 bucket, while testing the locking mechanism with DynamoDB. Participants will also configure variables and outputs using functions.

#### **Project Overview:**

You will create a Terraform configuration that uses a custom module to deploy a multi-component infrastructure on AWS. The state files will be stored remotely in an S3 bucket, and DynamoDB will handle state locking. Additionally, the project will involve creating a flexible and reusable Terraform module, using input variables (tfvars) and Terraform functions to parameterize configurations.

#### **Key Tasks:**

1. **Remote State Management:**  
   * **S3 Bucket for State**:  
     * Create an S3 bucket using Terraform (this can be separate from the custom module).  
     * Configure Terraform to store the state file in the S3 bucket.  

   * **State Locking with DynamoDB**:  
     * Create a DynamoDB table using Terraform (or manually if required) to store the state lock information.  
     * Configure Terraform to use this DynamoDB table for state locking.

    ![](./media/1.png)

2. **Terraform Module Creation:**  
   * **Custom Module**:  
     * Create a Terraform module to deploy the following AWS resources:  
       * **EC2 instance**: Use an AMI for the region and allow SSH access using a security group.  

       * **S3 bucket**: Create an S3 bucket for application data.  

        ![](./media/3.png)

3. **Input Variables and Configuration (tfvars):**  
   * Define input variables to make the infrastructure flexible:  
     * EC2 instance type.  
     * S3 bucket name.  
     * AWS region.  
     * Any other variable relevant to the infrastructure.  
   * Use the `default` argument for variables where appropriate.  

   ```
   created .tfvars file for each module
   ```
    ![](./media/2.png)

   
4. **Output Configuration:**  
   * Set up Terraform outputs to display key information after the infrastructure is created:  
     * **EC2 Public IP**: Output the public IP of the EC2 instance.  
     * **S3 Bucket Name**: Output the name of the S3 bucket created.  

    ![](./media/4.png)
 
5. **Apply and Modify Infrastructure:**  
   * **Initial Deployment**:  
     * Use `terraform plan` and `terraform apply` to deploy the infrastructure.  
     * Verify that the EC2 instance, S3 bucket, and all configurations are properly set up.  

    ![](./media/3.png)

   * **Infrastructure Changes**:  
     * Modify one of the variables (e.g., change the instance type or add tags) and re-run `terraform apply`.  
     * Observe how Terraform plans and applies only the necessary changes, with state locking in effect.  

    ![](./media/4.png)
    ![](./media/5.png)

    ![](./media/6.png)
    ![](./media/8.png)

6. **Resource Termination:**  
   * Once the deployment is complete and tested, use `terraform destroy` to tear down all the resources created by Terraform.  
   * Ensure that the S3 bucket, EC2 instance, and DynamoDB table (if not reused) are deleted.
    ![](./media/11.png)
    ![](./media/12.png)

