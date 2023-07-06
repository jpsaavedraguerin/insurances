output "jenkins_master_public_ip" {
   description = "The public IP address of the Jenkins Master"
   value = module.ec2_instances.jenkins_master_public_ip
}

output "jenkins_agents_public_ip" {
   description = "The public IP address of the Jenkins Agents"
   value = module.ec2_instances.jenkins_agents_public_ip
}

output "ecr_url" {
  description = "ecr name"
  value = moule.ecr.ecr_name
}

output "ecr_url" {
  description = "ecr url"
  value = moule.ecr.ecr_url
}