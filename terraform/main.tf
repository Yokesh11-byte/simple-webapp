provider "google" {
  credentials = file(var.credentials_file_path)  # GCP credentials file
  project     = var.project_id
  region      = var.region
}

# Create a GCS bucket to store Terraform state
resource "google_storage_bucket" "terraform_state" {
  name     = var.terraform_state_bucket
  location = "us-central1"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

# VPC Creation
resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks  = false
}

# Subnet Creation in the VPC
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.custom_vpc.name
  ip_cidr_range = var.subnet_cidr
  private_ip_google_access = true
}

# Firewall Rule to Allow Access to GKE Nodes
resource "google_compute_firewall" "allow_gke_access" {
  name    = var.firewall_name
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow access from anywhere (can be restricted as needed)
}

# Create GKE Cluster
resource "google_container_cluster" "primary" {
  name               = var.gke_cluster_name
  location           = var.gke_cluster_location
  initial_node_count = var.initial_node_count
  network            = google_compute_network.custom_vpc.name
  subnetwork         = google_compute_subnetwork.subnet.name

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Create Node Pool for GKE Cluster
resource "google_container_node_pool" "primary_nodes" {
  cluster   = google_container_cluster.primary.name
  location  = var.gke_cluster_location
  node_pool = var.node_pool_name

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  initial_node_count = var.initial_node_count
}
