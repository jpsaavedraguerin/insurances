# ------ SECURITY GROUP ------

# Variable to store the ID of our VPC
variable "vpc_id" {
  description = "ID of the VPC"
  type = string
}

# Variable to store our IP address from the secrets file
variable "local_ip" {
  description = "Local IP address"
  type = string
}

# Create security group (app_jenkins_sg)
resource "aws_security_group" "app_jenkins_sg" {
  name = "app_jenkins_sg"
  description = "Security group for jenkins server"
  vpc_id = var.vpc_id

  # Allow all traffic from the internet (port 9091)
  ingress {
    description = "Allow all traffic through port 9091"
    from_port = "9091"
    to_port = "9091"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow traffic only from "local IP" on port 22
  ingress {
    description = "Allow SSH from my local IP"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["${var.local_ip}/32"]
  }

  # Allow traffic to the internet
  egress {
    description = "Allow all outbound traffic"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tag
  tags = {
    Name = "app_jenkins_sg"
  }
}

