# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name        = aws_ecs_cluster.main.name
  capacity_providers  = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

# IAM Policy for ECS
data "aws_iam_policy_document" "task_execution_role_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "secretsmanager:GetSecretValue",
      "ssm:GetParameters",
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "task_execution_role_policy" {
  name        = "${var.prefix}-task-exec-role-policy"
  path        = "/"
  description = "Allow ECS tasks to access AWS services"
  policy      = data.aws_iam_policy_document.task_execution_role_policy.json
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.prefix}-ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "task_execution_role_ssm" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.prefix}-main"
  container_definitions    = data.template_file.api_container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_execution_role.arn

  volume {
    name = "efs-volume"
    efs_volume_configuration {
      file_system_id     = var.efs_id
      root_directory     = "/"
      transit_encryption = "ENABLED"
    }
  }

  tags = var.common_tags
}

# ECS Service
resource "aws_ecs_service" "main" {
  name                   = "${var.prefix}-ecs-service"
  cluster                = aws_ecs_cluster.main.name
  task_definition        = aws_ecs_task_definition.main.arn
  desired_count          = var.task_desired_count
  launch_type            = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "default-tm-devops-trainee-container"
    container_port   = 80
  }

  tags = var.common_tags
}

# Security Group for ECS
resource "aws_security_group" "ecs" {
  name        = "${var.prefix}-ecs-sg-new"
  description = "Security group for ECS"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.alb_sg]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.common_tags
}

data "template_file" "api_container_definitions" {
  template = file("${path.module}/templates/container-definitions.json.tpl")

  vars = {
    efs_id          = var.efs_id
    log_group_name  = var.cf_log_group_name
    log_group_region = var.region
    s3_bucket_name  = var.s3_bucket_name
  }
}
