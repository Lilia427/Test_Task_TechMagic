resource "aws_instance" "main" {
  ami           = var.ami              
  instance_type = "t2.micro"

  subnet_id               = var.subnet_a_id  
  vpc_security_group_ids  = [aws_security_group.ec2.id]

  tags = merge(var.common_tags, {
    Name = "${var.prefix}-ec2-instance"
  })

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y amazon-efs-utils
    sudo mkdir -p /mnt/efs
    sudo mount -t efs -o tls ${var.efs_id}:/ /mnt/efs
    echo "<h1>Hello, TechMagic!</h1>" | sudo tee /mnt/efs/index.html
  EOF
}

resource "aws_security_group" "ec2" {
  name        = "${var.prefix}-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.common_tags
}
