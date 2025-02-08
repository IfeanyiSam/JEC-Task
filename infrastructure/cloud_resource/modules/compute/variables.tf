# modules/compute/variables.tf
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

variable "ami_id" {
  description = "Ubuntu ami_id"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where instances will be created"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs where instances will be created"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to attach to instances"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
