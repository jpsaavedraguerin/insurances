output "jenkins_master_public_ip" {
   description = "The public IP address of the Jenkins Master"
   value = module.ec2_instances.jenkins_master_public_ip
}

output "jenkins_agents_public_ip" {
   description = "The public IP address of the Jenkins Agents"
   value = module.ec2_instances.jenkins_agents_public_ip
}