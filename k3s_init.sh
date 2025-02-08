#!/bin/bash

# Author: Nnanna Samuel Ifeanyi
# Role: DevOps Engineer
# Purpose: This script installs ArgoCD in the K3s VM and bootstraps ArgoCD

set -e
set -o pipefail

# Set Program Name
PROGNAME=$(basename "$0")

# Source the logging functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/logging.sh"

# Setup Kubernetes configuration
setup_kube_config() {
    log_info "Creating .kube directory..."
    mkdir -p $HOME/.kube || log_error "Failed to create .kube directory"

    log_info "Setting up rancher group..."
    sudo groupadd rancher 2>/dev/null || true
    sudo usermod -aG rancher $USER || log_error "Failed to add user to rancher group"

    log_info "Setting up directory permissions..."
    sudo chmod 755 /etc/rancher || log_error "Failed to set permissions for /etc/rancher"
    sudo chmod 755 /etc/rancher/k3s || log_error "Failed to set permissions for /etc/rancher/k3s"
    sudo chmod 755 /etc/rancher/k3s/config.yaml.d || log_error "Failed to set permissions for config.yaml.d"

    log_info "Setting ownership..."
    sudo chown -R root:rancher /etc/rancher/k3s || log_error "Failed to set ownership"
    sudo chmod -R g+r /etc/rancher/k3s || log_error "Failed to set group read permissions"

    log_info "Creating kubectl config..."
    sudo cat /etc/rancher/k3s/k3s.yaml > $HOME/.kube/config || log_error "Failed to create kubectl config"
    sudo chown $USER:$USER $HOME/.kube/config || log_error "Failed to set kubectl config ownership"
    chmod 600 $HOME/.kube/config || log_error "Failed to set kubectl config permissions"

    log_info "Updating shell configuration..."
    echo "export KUBECONFIG=$HOME/.kube/config" >> ~/.bashrc || log_error "Failed to update bashrc"
    source ~/.bashrc || log_error "Failed to source bashrc"
}

# Clone repository
clone_repo() {
    log_info "Cloning repository..."
    git clone https://github.com/IfeanyiSam/J_E_C_Task.git temp_repo || log_error "Failed to clone repository"
    log_success "Repository cloned successfully"
}


# Change directory and initialize terraform
init_terraform() {
    log_info "Changing directory to terraform configuration location..."
    cd temp_repo/infrastructure/argocd-terraform/main || log_error "Failed to change directory"
    log_success "Changed directory successfully"

    log_info "Initializing Terraform..."
    terraform init || log_error "Terraform initialization failed"
    log_success "Terraform initialized successfully"
}

# Run terraform plan
run_terraform_plan() {
    log_info "Running Terraform plan..."
    terraform plan || log_error "Terraform plan failed"
    log_success "Terraform plan completed successfully"
}

# Apply terraform configuration
apply_terraform() {
    log_info "Applying Terraform configuration..."
    terraform apply -auto-approve || log_error "Terraform apply failed"
    log_success "Terraform configuration applied successfully"
}

apply_root_and_get_password() {
    log_info "Applying root configuration..."
    kubectl apply -f ~/temp_repo/demo-dev/root.yaml || log_error "Failed to apply root configuration"
    kubectl patch svc argocd-dev-server -n argocd -p '{"spec": {"type": "NodePort"}}'
    kubectl get svc argocd-dev-server -n argocd -o wide

    log_info "Retrieving ArgoCD initial admin password..."
    sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d || log_error "Failed to retrieve ArgoCD password"
    echo
}

# Main execution
main() {
    log_info "Starting k3s initialization script..."
    setup_kube_config
    clone_repo
    init_terraform
    run_terraform_plan
    apply_terraform
    apply_root_and_get_password
    log_success "k3s initialization completed successfully"
}

# Execute main function
main
