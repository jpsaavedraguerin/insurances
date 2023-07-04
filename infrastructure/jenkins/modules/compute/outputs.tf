output "jenkins_master_public_ip" {
  description = "The public IP address of the Jenkins Master"
  value = aws_eip.jenkins_master_eip.public_ip
}

# output "jenkins_agent_public_ip" {
#   description = "The public IP address of the Jenkins Agent"
#   value = aws_eip.jenkins_master_eip.public_ip
# }

output "jenkins_agents_public_ip" {
  value = ["${aws_instance.jenkins_build_agent.*.public_ip}"]
}