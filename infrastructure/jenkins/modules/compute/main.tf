# ------ EC2 Instances ------

# Variable to store Jenkins sg ID
variable "security_group" {
  description = "The sg assigned to the Jenkins Server"
}

# Variable to store subnet ID
variable "public_subnet" {
  description = "The public subnet IDs assigned to the Jenkins Server"
}

# Variable to store public key path
variable "public_key_path" {
  description = "The path to the public key .pem"
}

# Data store for the AWS Linux AMI
data "aws_ami" "amazon-linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# Create a key pair in AWS
resource "aws_key_pair" "app_kp" {
   key_name   = "app_kp"

   # Passing the public key of the key pair we created
   public_key = file(var.public_key_path) # TODO: change dinamicaly
}


# Create Jenkins Master
resource "aws_instance" "jenkins_master" {
  # Select ami from data store
  ami = data.aws_ami.amazon-linux.id

  # Select subnet as the public subnet
  subnet_id = var.public_subnet

  # Set instance type
  instance_type = "t2.micro" # free-tier

  # Set security group
  vpc_security_group_ids = [var.security_group]

  # Set key pair name 
  key_name = aws_key_pair.app_kp.key_name

  # Set user data to bash file install_jenkins.sh
  user_data = "${file("${path.module}/install_jenkins.sh")}"

  # Tag
  tags = {
    Name = "jenkins-master"
  }
}


# Create Jenkins Agent
resource "aws_instance" "jenkins_build_agent" {
    ami = data.aws_ami.amazon-linux.id
    count = 1
    subnet_id = var.public_subnet
    instance_type = "t2.micro"
    key_name = aws_key_pair.app_kp.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [var.security_group] # This Security Group has port [9090,9091] opened
    user_data = "${file("${path.module}/prepare_agent.sh")}"

    tags = {
        Name = "jenkins-agent-${count.index+1}"
    }
}

# Create an Elastic IP for jenkins_master
resource "aws_eip" "jenkins_master_eip" {
   # Attaching it to the jenkins_master EC2 instance
   instance = aws_instance.jenkins_master.id

   # Making sure it is inside the VPC
   vpc = true

   # Setting the tag Name to jenkins_eip
   tags = {
      Name = "jenkins_master_eip"
   }
}