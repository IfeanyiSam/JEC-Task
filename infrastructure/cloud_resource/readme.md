# Cloud Infrastructure with Terraform

## Project Overview
This project contains Terraform configurations to provision and manage cloud infrastructure using a modular approach. The infrastructure is organized into distinct modules for better maintainability and reusability.

## Directory Structure

```markdown
.
├── backend.tf
├── main.tf
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── providers.tf
├── readme.md
├── scripts
│   ├── install_docker.sh
│   ├── k3s_init.sh
│   ├── logging.sh
│   └── rancher.sh
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf


## Modules Description

### VPC Module
- Manages network infrastructure
- Creates VPC, subnets, route tables, and internet gateway
- Handles network ACLs and routing configurations

### Security Module
- Manages security groups and firewall rules
- Configures network access controls

### Compute Module
- Manages compute resources
- Handles instance provisioning

## Prerequisites
- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- Required Access Credentials to create resources

## Getting Started
1. Clone the repository:

git clone 'https://github.com/IfeanyiSam/J_E_C_TASK' temp

cd temp/infrastructure/cloud_resource

## Deployment

1. Initialize Terraform:

terraform init


2. Plan the deployment:
terraform plan


3. Apply the changes:
terraform apply


4. To destroy the infrastructure:
terraform destroy
