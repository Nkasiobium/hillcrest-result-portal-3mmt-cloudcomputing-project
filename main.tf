terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Find the latest Ubuntu 24.04 LTS AMI
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# Use the default VPC in us-east-1
data "aws_vpc" "default" {
  default = true
}

# Get available subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group
resource "aws_security_group" "hill_crest_portal" {
  name = "hill-crest-result-portal-sg"
  description = "Security group for Hill Crest Secondary School Result Portal"
  vpc_id = data.aws_vpc.default.id

  # Public HTTP access
  ingress {
    description = "HTTP web traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access restricted to administrator IP
  ingress {
    description = "SSH administrator access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # Allow outbound traffic
  egress {
    description = "Allow outbound internet traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hill-crest-result-portal-sg"
    Project = "Hill-Crest-Result-Portal"
    Managed = "Terraform"
  }
}

# EC2 instance
resource "aws_instance" "hill_crest_portal" {
  ami = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.default.ids[0]

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.hill_crest_portal.id
  ]

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash

    set -e

    exec > >(tee /var/log/hill-crest-deployment.log | logger -t hill-crest-user-data -s 2>/dev/console) 2>&1

    echo "Starting Hill Crest Result Portal deployment..."

    # ----------------------------------------
    # 1. Update Ubuntu
    # ----------------------------------------
    apt-get update -y
    apt-get upgrade -y

    # ----------------------------------------
    # 2. Install required packages
    # ----------------------------------------
    apt-get install -y git curl nginx

    # ----------------------------------------
    # 3. Install Node.js 22
    # ----------------------------------------
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    apt-get install -y nodejs

    # ----------------------------------------
    # 4. Install PM2
    # ----------------------------------------
    npm install -g pm2

    # ----------------------------------------
    # 5. Clone Hill Crest Result Portal
    # ----------------------------------------
    mkdir -p /var/www

    cd /var/www

    rm -rf hillcrest-result-portal-3mmt-cloudcomputing-project

    git clone \
      https://github.com/Nkasiobium/hillcrest-result-portal-3mmt-cloudcomputing-project.git \
      hillcrest-result-portal-3mmt-cloudcomputing-project

    cd /var/www/hillcrest-result-portal-3mmt-cloudcomputing-project

    chown -R ubuntu:ubuntu /var/www/hillcrest-result-portal-3mmt-cloudcomputing-project

    # ----------------------------------------
    # 6. Install application dependencies
    # ----------------------------------------
    sudo -u ubuntu npm install

    # ----------------------------------------
    # 7. Create production environment file
    # ----------------------------------------
    cat > .env <<'ENVFILE'
NODE_ENV=production
SCHOOL_NAME=Hill Crest Secondary School, Awada
PORT=3000
ENVFILE

    chown ubuntu:ubuntu .env
    chmod 600 .env

    # ----------------------------------------
    # 8. Start application with PM2
    # ----------------------------------------
    sudo -u ubuntu pm2 start server.js \
      --name hill-crest-result-portal

    sudo -u ubuntu pm2 save

    # Configure PM2 to start after reboot
    env PATH=$PATH:/usr/bin pm2 startup systemd \
      -u ubuntu \
      --hp /home/ubuntu | tail -n 1 | bash || true

    # ----------------------------------------
    # 9. Configure Nginx
    # ----------------------------------------
    cat > /etc/nginx/sites-available/hill-crest-result-portal <<'NGINX'
server {
    listen 80;
    listen [::]:80;

    server_name _;

    location / {
        proxy_pass http://127.0.0.1:3000;

        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINX

    # ----------------------------------------
    # 10. Enable Nginx configuration
    # ----------------------------------------
    rm -f /etc/nginx/sites-enabled/default

    ln -s \
      /etc/nginx/sites-available/hill-crest-result-portal \
      /etc/nginx/sites-enabled/hill-crest-result-portal

    # ----------------------------------------
    # 11. Test and restart Nginx
    # ----------------------------------------
    nginx -t

    systemctl enable nginx
    systemctl restart nginx

    echo "Hill Crest Result Portal deployment completed successfully."
  EOF

  # 20 GB encrypted GP3 storage
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted = true
  }

  tags = {
    Name = "Hill-Crest-Result-Portal"
    Project = "Hill-Crest-Result-Portal"
    Managed = "Terraform"
  }
}
