provider "aws" {
  region = "us-east-1"
}

# Key Pair (replace with your existing public key if needed)
/*resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}*/

# Security Group allowing SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ Replace with your IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get default VPC and subnet
data "aws_vpc" "default" {
  default = true
}



data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-020cba7c55df1f615" # Ubuntu 24.04 LTS
  instance_type = "t2.micro"
  key_name      = "kube-demo"
  subnet_id     = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "MyEC2Instance"
  }
}

