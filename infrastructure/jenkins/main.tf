terraform {
   required_providers {
      aws = {
         source = "hashicorp/aws"
         version = "4.0.0"
      }
   }

   required_version = "~> 1.5.1"
}

provider "aws" {
   region = var.aws_region
}


module "vpc" {
   source = "./modules/vpc"
   vpc_cidr_block = var.vpc_cidr_block
   public_subnet_cidr_block = var.public_subnet_cidr_block
}

module "security_group" {
   source = "./modules/security_group"
   vpc_id = module.vpc.vpc_id
   local_ip = var.local_ip
}

module "ec2_instances" {
   source = "./modules/compute"
   public_key_path = var.public_key_path
   security_group = module.security_group.app_jenkins_sg
   public_subnet = module.vpc.public_subnet_id
}

module "ecr" {
   source = "./modules/ecr"
}