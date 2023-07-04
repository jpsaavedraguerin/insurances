# ----------- VPC -----------
# CIDR block for the VPC
variable "vpc_cidr_block" {
    description = "CIDR block of the VPC"
}

# Create VPC "aws_vpc"
resource "aws_vpc" "app_vpc" {
    # Setting the CIDR block of the VPC to vpc_cidr_block variable  
    cidr_block = var.vpc_cidr_block

    # Enabling DNS hostnames on the VPC
    enable_dns_hostnames = true

    # Tag name
    tags = {
        Name = "app_vpc"
    }
}

# --------- GATEWAY ---------

# Internet Gateway
resource "aws_internet_gateway" "app_igw" {
    # Attach it to VPC (app_vpc)
    vpc_id = aws_vpc.app_vpc.id

    # Tag name
    tags = {
      Name = "app_igw"
    }
}

# Public route table
resource "aws_route_table" "public" {
  # Create it inside the VPC app_vpc
  vpc_id = aws_vpc.app_vpc.id

  # Adding the igw to the rt
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
}

# ------ PUBLIC SUBNET ------

# CIDR block for the public subnet
variable "public_subnet_cidr_block" {
    description = "CIDR block of the public subnet"
}

# Data store for the AZs in our region
data "aws_availability_zones" "available" {
    state = "available"
}

# Public subnet (app_public_subnet)
resource "aws_subnet" "app_public_subnet" {
  # Create it inside aws_vpc VPC
  vpc_id = aws_vpc.app_vpc.id

  # Set CIDR block to public_subnet_cidr_block
  cidr_block = var.public_subnet_cidr_block
  
  # Set AZ to the first one in our AZ data store
  availability_zone = data.aws_availability_zones.available.names[0]

  # Tag
  tags = {
    Name = "app_public_subnet"
  }
}

# Asociate public subnet with public rt

resource "aws_route_table_association" "public" {
  # ID of the public rt (public)
  route_table_id = aws_route_table.public.id

  # ID of public subnet (app_public_subnet)
  subnet_id = aws_subnet.app_public_subnet.id
}