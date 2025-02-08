# terraform/main.tf
# provider "aws" {
#   region = var.aws_region
# }

module "vpc" {
  source = "./modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  tags = {
    Project     = "JEC-Task"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "security" {
  source = "./modules/security"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id

  tags = {
    Project     = "JEC-Task"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "compute" {
  source = "./modules/compute"

  environment        = var.environment
  instance_type      = var.instance_type
  public_key_path    = var.public_key_path
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security.rancher_sg_id, module.security.k3s_sg_id]

  tags = {
    Project     = "JEC-Task"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
