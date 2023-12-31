variable "aws_region" {
   default = "us-east-1"
}

variable "vpc_cidr_block" {
   description = "CIDR block for VPC"
   type = string
   default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
   description = "CIDR block for public subnet"
   type = string
   default = "10.0.1.0/24"
}

variable "local_ip" {
   description = "Local IP address"
   type = string
   sensitive = true
}

variable "public_key_path" {
   description = "Path to the public key .pem"
   type = string
   sensitive = true
}