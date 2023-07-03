# ----- Security Groups outputs -----
output "sg_id" {
  description = "The ID of the security group"
  value = aws_security_group.app_jenkins_sg.id
}