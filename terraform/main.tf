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
  security_groups = [aws_security_group.flask-access.name]
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

resource "aws_s3_bucket" "thiringai-terraform" {
  bucket = "thiringai-terraform"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags ={
    Name = "S3 Remote Terraform State Store"
  }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

resource "aws_instance" "ansible-worker" {
  # ...instance configuration...
  #...import instance state
  ami             = "ami-0ab4d1e9cf9a1215a"
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [aws_security_group.flask-access.name]
  tags = {
    Name = "ansible-worker"
  }
}

output "ec2_public_ip" {
  value = aws_instance.TF-instance.public_ip
}
