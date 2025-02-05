resource "aws_lb" "main" {
  name               = "${var.prefix}-alb"
  load_balancer_type = "application"
  subnets = [
    var.subnet_a_id,
    var.subnet_b_id,
    var.subnet_c_id
  ]
  ip_address_type = "ipv4"

  security_groups = [aws_security_group.alb.id]

  tags = var.common_tags
}

resource "aws_lb_target_group" "ecs" {
  name        = "${var.prefix}-ecs-tg"
  protocol    = "HTTP"
  port        = 80
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check_url
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.common_tags
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.prefix}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.common_tags
}



resource "aws_security_group_rule" "alb_to_ec2" {
  type                     = "ingress"
  security_group_id        = var.ec2_sg_id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}
