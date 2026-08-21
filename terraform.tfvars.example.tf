# Hill Crest Secondary School Result Portal
# AWS deployment configuration

aws_region = "us-east-1"
instance_type = "t2.micro"
key_name = "hill-crest-key"

# Replace this with YOUR current public IPv4 address.
# Example:
# admin_ip = "203.0.113.10/32"
#
# Do not use 0.0.0.0/0 for SSH in a production environment.
admin_ip = "YOUR_PUBLIC_IP/32"