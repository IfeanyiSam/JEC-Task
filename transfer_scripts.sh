#!/bin/bash

# Define variables
REMOTE_USER="ubuntu"
REMOTE_IP="K3s_VM_public_IP_address" # this is a placeholder
KEY_PATH="path_to_VM_private_key" # this is a placeholder  
LOCAL_PATH="path_to_scripts"  # this is a placeholder
LOCAL_SCRIPTS=("k3s_init.sh" "logging.sh")
REMOTE_PATH="/home/ubuntu"

# Function to check if files exist locally
check_files() {
    for file in "${LOCAL_SCRIPTS[@]}"; do
        if [ ! -f "${LOCAL_PATH}/${file}" ]; then
            echo "Error: ${LOCAL_PATH}/${file} not found"
            exit 1
        fi
    done
}

# Function to copy files using SCP
copy_files() {
    echo "Copying files to remote VM..."
    for file in "${LOCAL_SCRIPTS[@]}"; do
        echo "Transferring $file..."
        scp -i "$KEY_PATH" "${LOCAL_PATH}/${file}" "${REMOTE_USER}@${REMOTE_IP}:${REMOTE_PATH}"
        if [ $? -eq 0 ]; then
            echo "Successfully copied $file"
        else
            echo "Failed to copy $file"
            exit 1
        fi
    done
}

# Function to set execute permissions on remote files
set_permissions() {
    echo "Setting execute permissions on remote files..."
    for file in "${LOCAL_SCRIPTS[@]}"; do
        ssh -i "$KEY_PATH" "${REMOTE_USER}@${REMOTE_IP}" "chmod +x ${REMOTE_PATH}/${file}"
        if [ $? -eq 0 ]; then
            echo "Successfully set permissions for $file"
        else
            echo "Failed to set permissions for $file"
            exit 1
        fi
    done
}

# Main execution
main() {
    check_files
    copy_files
    set_permissions
    echo "File transfer completed successfully!"
}

main
