output "efs_id" {
  value = aws_efs_file_system.efs.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.efs_ap.id
}

output "mount_target_ids" {
  value = { for k, v in aws_efs_mount_target.efs : k => v.id }
}
