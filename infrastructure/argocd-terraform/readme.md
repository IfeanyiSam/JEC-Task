# Cloud Infrastructure with Terraform

## Project Overview
This project contains Terraform configurations to provision ArgoCD in the K3s VM

## Directory Structure

```markdown
.
├── main
│   ├── main.tf
│   ├── providers.tf
│   └── variables.tf
├── modules
│   └── argocd
│       ├── helm-values.yaml
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── readme.md


## Modules Description

### ArgoCD Module
- This provisions create a namespace in cluster argocd and provisions the ArgoCD application in the cluster using the ArgoCD helm repository making use of custom values to use a nodeport service type


## Getting Started
1. Clone the repository:

git clone 'https://github.com/IfeanyiSam/J_E_C_TASK' temp

cd temp/infrastructure/argocd-terraform/main

## Deployment

1. Initialize Terraform:

terraform init


2. Plan the deployment:
terraform plan


3. Apply the changes:
terraform apply


4. To destroy the infrastructure:
terraform destroy
