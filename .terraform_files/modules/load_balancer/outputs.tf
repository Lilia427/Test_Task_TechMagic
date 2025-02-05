output "alb_arn" {
  value = aws_lb.main.arn
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_sg" {
  value = aws_security_group.alb.id
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.ecs.arn
}
