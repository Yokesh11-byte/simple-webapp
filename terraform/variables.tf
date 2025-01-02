variable "project_id" {
  description = "The GCP project ID where resources will be deployed"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the GKE cluster will be created"
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  description = "The name of the custom VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "192.168.1.0/24"
}

variable "firewall_name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "gke_cluster_location" {
  description = "The location of the GKE cluster"
  type        = string
}

variable "initial_node_count" {
  description = "The initial number of nodes in the GKE cluster"
  type        = number
  default     = 2
}

variable "node_machine_type" {
  description = "The machine type for the GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "node_pool_name" {
  description = "The name of the node pool within the GKE cluster"
  type        = string
}

variable "terraform_state_bucket" {
  description = "The name of the GCS bucket for storing Terraform state"
  type        = string
}

variable "credentials_file_path" {
  description = "The path to the GCP credentials file"
  type        = string
}
