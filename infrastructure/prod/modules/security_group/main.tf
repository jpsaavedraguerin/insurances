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

  # Allow all traffic between instances in the same sg
  ingress {
          from_port = 0
          to_port = 0
          protocol = -1
          self = true
  }

  # Allow all traffic from the internet (port 9090)
  ingress {
    description = "Allow all traffic through port 9090"
    from_port = "9090"
    to_port = "9090"
    protocol = "tcp"
    cidr_blocks = ["${var.local_ip}/32"] #TODO: allow inbound traffic from local IP only
  }

  # Allow all traffic from the internet (port 9091)
  ingress {
    description = "Allow all traffic through port 9091"
    from_port = "9091"
    to_port = "9091"
    protocol = "tcp"
    cidr_blocks = ["${var.local_ip}/32"] #TODO: allow inbound traffic from local IP only
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

  # Github communication 
  ingress {
    description = "Allow inbound traffic from github"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "20.87.225.212/32",
    "20.248.137.48/32",
    "20.207.73.82/32",
    "20.27.177.113/32",
    "20.200.245.247/32",
    "20.233.54.53/32"]
  }

  ingress {
    description = "Allow inbound traffic from github"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "20.87.225.212/32",
    "20.248.137.48/32",
    "20.207.73.82/32",
    "20.27.177.113/32",
    "20.200.245.247/32",
    "20.233.54.53/32"]
  }

  ingress {
    description = "Allow inbound traffic from github"
    from_port = "9091"
    to_port = "9091"
    protocol = "tcp"
    cidr_blocks = ["192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "20.87.225.212/32",
    "20.248.137.48/32",
    "20.207.73.82/32",
    "20.27.177.113/32",
    "20.200.245.247/32",
    "20.233.54.53/32"]
  }

  ingress {
    description = "Allow inbound traffic from github"
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "20.87.225.212/32",
    "20.248.137.48/32",
    "20.207.73.82/32",
    "20.27.177.113/32",
    "20.200.245.247/32",
    "20.233.54.53/32"]
  }

  egress {
    description = "Allow inbound traffic from github"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "20.87.225.212/32",
    "20.248.137.48/32",
    "20.207.73.82/32",
    "20.27.177.113/32",
    "20.200.245.247/32",
    "20.233.54.53/32"]
  }

  # Tag
  tags = {
    Name = "app_jenkins_sg"
  }
}