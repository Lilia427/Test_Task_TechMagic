# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.prefix}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json

  tags = var.common_tags
}

data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Policy for ECS Task Execution Role
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "${var.prefix}-ecs-task-execution-policy"
  description = "Policy for ECS task to access required AWS resources"
  policy      = data.aws_iam_policy_document.ecs_task_policy.json
}

data "aws_iam_policy_document" "ecs_task_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "elasticfilesystem:*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

# Attach Policy to ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

# Security credentials stored in SSM (optional)
resource "aws_ssm_parameter" "ecs_execution_role_arn" {
  name        = "/${terraform.workspace}/${var.project_name}/ecs_execution_role_arn"
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
  type        = "SecureString"
  tags        = var.common_tags
}
