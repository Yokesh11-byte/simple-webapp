# GCP Project ID and Region
project_id         = "your-project-id" 
region             = "us-central1" 
zone               = "us-central1-a"

# Custom VPC and Subnet
vpc_name           = "custom-vpc"
subnet_name        = "web-app-subnet"
subnet_cidr        = "192.168.1.0/24"

# Firewall Configuration
firewall_name      = "allow-gke-access"

# GKE Cluster Configuration
gke_cluster_name   = "web-app-cluster"
gke_cluster_location = "us-central1-c"
initial_node_count = 2
node_machine_type  = "e2-medium"
node_pool_name     = "default-node-pool"

# GCS Bucket for Terraform State
terraform_state_bucket = "webapp-terraform-state-bucket"

# GCP Credentials File Path
credentials_file_path = "/path/to/your/credentials-file.json" #path for gcp creds
