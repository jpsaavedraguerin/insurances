output "public_ip" {
  description = "The public IP address of the Jenkins Master"
  value = aws_eip.jenkins_master_eip.public_ip
}