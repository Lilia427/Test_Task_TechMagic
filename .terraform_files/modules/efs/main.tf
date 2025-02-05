# Amazon EFS
resource "aws_efs_file_system" "efs" {
  creation_token = "${var.prefix}-efs"
  encrypted      = true

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = merge({ "Name" = "${var.prefix}-efs" }, var.common_tags)
}

# Security Group for EFS
resource "aws_security_group" "efs_sg" {
  name        = "${var.prefix}-efs-sg"
  description = "Security group for EFS access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow NFS access from ECS tasks"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [var.ecs_sg]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ "Name" = "${var.prefix}-efs-sg" }, var.common_tags)
}

# EFS Mount Targets
resource "aws_efs_mount_target" "efs" {
  for_each = {
    subnet_a = var.subnet_a_id
    subnet_b = var.subnet_b_id
    subnet_c = var.subnet_c_id
  }

  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value
  security_groups = [aws_security_group.efs_sg.id]
}

# EFS Access Point 
resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs.id

  posix_user {
    uid = 1000
    gid = 1000
  }

  root_directory {
    path = "/"
    creation_info {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = "755"
    }
  }
}
