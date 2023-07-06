# ----- Security Groups outputs -----
output "app_jenkins_sg" {
  description = "The ID of the security group"
  value = aws_security_group.app_jenkins_sg.id
}