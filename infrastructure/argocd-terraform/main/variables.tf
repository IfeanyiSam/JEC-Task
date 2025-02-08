variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "argocd_namespace" {
  description = "Namespace for ArgoCD"
  type        = string
  default     = "argocd"
}
