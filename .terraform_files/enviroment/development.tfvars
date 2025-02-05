project_name        = "tm-devops-trainee"
region              = "us-east-1"
app_port            = 80
health_check_url    = "/"
task_cpu            = 256
task_memory         = 512
task_desired_count  = 1
vpc_cidr_block      = "10.0.0.0/16"
subnet_a_cidr_block = "10.0.1.0/24"
subnet_b_cidr_block = "10.0.2.0/24"
subnet_c_cidr_block = "10.0.3.0/24"
environment         = "development"

# S3 Bucket
s3_bucket_name = "default-tm-devops-trainee-html-bucket"

# EC2 Instance
ami       = "ami-032ae1bccc5be78ca"
subnet_id = "subnet-0b615fd8399779431"


subnet_a_id = "subnet-0b615fd8399779431"
subnet_b_id = "subnet-0b62895b3d3745a58"
subnet_c_id = "subnet-0b296727508894840"
efs_id    = "fs-0344ff2237ce52daf"
vpc_id    = "vpc-0b96496ad349c9610"
ec2_sg    = "sg-0cc05703103bff507"

# Common Tags
common_tags = {
  Environment = "Development"
  Project     = "tm-devops-trainee"
}

cf_log_group_name   = "tm-devops-trainee-ecs-task-logs"
prefix              = "tm-devops-trainee"