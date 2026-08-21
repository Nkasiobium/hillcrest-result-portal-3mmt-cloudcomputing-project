variable "aws_region" {
  description = "AWS region for the Hill Crest Result Portal."
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for the Hill Crest Result Portal."
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name in the selected AWS region."
  type = string
  default = "hill-crest-key"
}

variable "admin_ip" {
  description = "Administrator public IPv4 address allowed to SSH into the EC2 instance. Use /32."
  type = string

  validation {
    condition = can(cidrhost(var.admin_ip, 0))
    error_message = "admin_ip must be a valid IPv4 CIDR such as 203.0.113.10/32."
  }
}