# TechMagic_Test_task
## General URL’s


| **Provider**         | **Service Name**            | **URL**             |
|----------------------|-----------------------------|---------------------|
| Hosting provider     | AWS (ECS, ECR, ALB)         |                     |
| DNS provider         | AWS Route 53                |                     |
| SSL Storage          | AWS ACM                     |                     |
| Logs Provider        | AWS CloudWatch              |                     |
| Error Handling       | AWS Lambda / Sentry         |                     |
| Performance Monitoring| New Relic / Datadog         |                     |
| Email Provider       | AWS SES                     |                     |



## Tech details

1. **VPC**: 
   - Manages the virtual network for the application.
   - Defined in the `vpc` module.
   
2. **EC2**:
   - Manages EC2 instances for additional compute resources.
   - Defined in the `ec2` module.
   
3. **ECS Fargate**:
   - Deploys containers using ECS Fargate for managing compute resources for containers.
   - Defined in the `ecs_fargate` module.
   
4. **EFS**:
   - Provides shared storage for the application.
   - Defined in the `efs` module.
   
5. **IAM**:
   - Manages AWS Identity and Access Management roles and policies for secure access to resources.
   - Defined in the `iam` module.
   
6. **Load Balancer**:
   - Configures an Application Load Balancer (ALB) to distribute traffic across ECS tasks.
   - Defined in the `load_balancer` module.
   
7. **S3**:
   - Stores static files such as the `index.html` file.
   - Defined in the `s3` module.

## Installation & Lunch using Docker

How to run a project locally using Docker?
1. **Preparing:**

   Before running the project locally, ensure that Docker and Docker Compose are properly installed and configured on your machine. 
   
      ```bash
    git clone
    cd .terraform_files
    ```

2. **Start server:**
  
    Build and start the containers:
    ```bash
    docker build -t nginx-with-awscli:latest .
    ```
   
    
3. **Stop server:**
    ```bash
    docker stop <container_id>
    ```

4. **Initialize migrations**:

5. **Generate migrations**:
 
6. **Run migrations**:

7. Run seeds

   
8. Show logs

9. **Accessing the Application**:
   
    ```bash
    http://localhost:8080/
    ```
