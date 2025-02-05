resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name              = var.cf_log_group_name
  retention_in_days = 7

  tags = merge(
    {
      "Name" = var.cf_log_group_name
    },
    var.common_tags
  )
}
