module "argocd" {
  source = "../modules/argocd"

  name      = "argocd-${var.environment}"
  namespace = var.argocd_namespace
}
