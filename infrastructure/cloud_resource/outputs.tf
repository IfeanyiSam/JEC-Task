# terraform/outputs.tf
output "rancher_instance_ip" {
  description = "Public IP of Rancher instance"
  value       = module.compute.rancher_instance_ip
}

output "k3s_instance_ip" {
  description = "Public IP of K3s instance"
  value       = module.compute.k3s_instance_ip
}
