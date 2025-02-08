# modules/security/outputs.tf
output "rancher_sg_id" {
  description = "ID of the Rancher security group"
  value       = aws_security_group.rancher.id
}

output "k3s_sg_id" {
  description = "ID of the K3s security group"
  value       = aws_security_group.k3s.id
}
