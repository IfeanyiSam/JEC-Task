output "namespace" {
  description = "The namespace ArgoCD is deployed to"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "release_name" {
  description = "The name of the Helm release"
  value       = helm_release.argocd.name
}
