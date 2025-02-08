variable "name" {
  description = "Name of the ArgoCD deployment"
  type        = string
  default     = "argocd"
}

variable "namespace" {
  description = "Namespace to deploy ArgoCD"
  type        = string
  default     = "argocd"
}

variable "repository" {
  description = "Helm repository URL"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "chart" {
  description = "Chart name"
  type        = string
  default     = "argo-cd"
}

variable "chart_version" {
  description = "Chart version"
  type        = string
  default     = "5.46.7"
}
