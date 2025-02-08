# modules/compute/outputs.tf
output "rancher_instance_ip" {
  description = "Public IP of Rancher instance"
  value       = aws_instance.rancher.public_ip
}

output "k3s_instance_ip" {
  description = "Public IP of K3s instance"
  value       = aws_instance.k3s.public_ip
}
