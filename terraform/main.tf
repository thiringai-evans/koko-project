provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "flask-access" {
  name        = "flask-access"
  description = "security group for flask-app"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "flask-access"
  }
}

resource "aws_instance" "TF-instance" {
  ami             = "ami-0c536cd6abac1a385"
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [aws_security_group.flask-access.id]
  user_data = file("entry-script.sh")
  tags = {
    Name = "TF-instance"
  }
}

# Create Elastic IP address
resource "aws_eip" "flask-access" {
  vpc      = true
  instance = aws_instance.TF-instance.id
  tags = {
    Name = "flask-access-ip"
  }
}

output "ec2_public_ip" {
  value = aws_instance.TF-instance.public_ip
}
