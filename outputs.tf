output "instance_id" {
  description = "EC2 instance ID for the Hill Crest Result Portal."
  value = aws_instance.hill_crest_portal.id
}

output "public_ip" {
  description = "Public IPv4 address of the Hill Crest Result Portal."
  value = aws_instance.hill_crest_portal.public_ip
}

output "portal_url" {
  description = "Public URL of the Hill Crest Result Portal."
  value = "http://${aws_instance.hill_crest_portal.public_ip}"
}

output "health_check_url" {
  description = "Health check endpoint for the application."
  value = "http://${aws_instance.hill_crest_portal.public_ip}/health"
}

output "security_group_id" {
  description = "Security Group ID for the Hill Crest Result Portal."
  value = aws_security_group.hill_crest_portal.id
}

output "ssh_command" {
  description = "SSH command for administrator access."
  value = "ssh -i <path-to-hill-crest-key.pem> ubuntu@${aws_instance.hill_crest_portal.public_ip}"
}
