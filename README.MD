## 🌐 Web App 🚀 Deployment with Prometheus 📊 Monitoring on GKE 🛠️

#### This guide provides detailed instructions for deploying a 🌐 web application along with Prometheus 📊 monitoring on Google Kubernetes Engine (GKE) 🛠️. Deployment is automated using Terraform 🏗️ and GitHub Actions 🤖, ensuring a streamlined CI/CD process.

### 📂 Project Directory Overview

### The project structure is organized as follows:

```
├── .github/
│   └── workflows/
│       ├── gke-provisioning.yaml       # 🛠️ Workflow for provisioning GKE cluster using Terraform
│       └── app-deployment.yaml         # 🚀 Workflow for deploying the web app and Prometheus
├── manifests/
│   ├── webapp-deployment.yaml          # 📦 Kubernetes deployment manifest for the web app
│   ├── webapp-service.yaml             # 🌐 Kubernetes service for exposing the web app
├── monitoring/
│   ├── namespace.yaml                  # 🗂️ Namespace configuration for monitoring
│   ├── prometheus-clusterrole.yaml     # 🔑 Cluster role and permissions for Prometheus
│   ├── prometheus-configmap.yaml       # ⚙️ Prometheus configuration file
│   ├── prometheus-deployment.yaml      # 📦 Prometheus deployment manifest
│   └── prometheus-service.yaml         # 🌐 Service manifest for Prometheus
├── terraform/
│   ├── main.tf                         # 🏗️ Main Terraform configuration for GKE
│   ├── variables.tf                    # 📋 Input variables for Terraform
│   ├── terraform.tfvars                # 📝 Values for Terraform variables
│   ├── backend.tf                      # 🗂️ Backend configuration for state management
│   └── outputs.tf                      # 🔄 Outputs from the Terraform setup
├── src/
│   └── index.html                      # 🌐 Web app’s main HTML file
├── Dockerfile                          # 🐳 Dockerfile to containerize the web app
└── README.md                           # 📘 This file
```
## 🚀 Deployment Process

### 1️⃣ Provision GKE Cluster with Terraform 🏗️

Use Terraform 🛠️ to provision the necessary infrastructure on Google Cloud ☁️, including:

GKE Cluster: 🛠️ Hosts the 🌐 web app and Prometheus 📊.

Networking: 🌐 Sets up the required VPC and subnet configurations.

#### 📝 Terraform Configuration Files:

* main.tf: Core configuration for GKE provisioning.

* variables.tf: Defines variables like project ID and cluster name.

* terraform.tfvars: Provides values for the variables.

* backend.tf: Configures state storage for Terraform.

* outputs.tf: Exposes the GKE cluster details post-provisioning.

#### Run the Terraform provisioning via the gke-provisioning.yaml GitHub Actions workflow 🤖, which automates the following steps:

* 🔧 Initialize Terraform: terraform init

* 🛠️ Plan and apply: terraform apply -auto-approve

### 2️⃣ Build and Deploy the Web App 🌐

#### After the GKE cluster is provisioned, deploy the web app 📦.

#### 🌐 Web App Configuration:

* Dockerfile 🐳: Builds a container using the Caddy web server to serve the index.html file from the src/ directory.

##### Kubernetes Manifests 📋:

* webapp-deployment.yaml: Deploys the web app as a Kubernetes Deployment.

* webapp-service.yaml: Exposes the web app as a Kubernetes Service.

#### These configurations are applied automatically via the app-deployment.yaml GitHub Actions workflow 🤖, which:

* 🐳 Builds the Docker image.

* 📤 Pushes the image to a container registry.

* 📋 Applies the Kubernetes manifests using kubectl.

### 3️⃣ Configure Prometheus Monitoring 📊

#### Deploy Prometheus 📊 to monitor your GKE cluster and the web app 🌐.

#### 📋 Prometheus Configuration:

* Namespace 🗂️: Defined in namespace.yaml to isolate monitoring resources.

* Cluster Role 🔑: prometheus-clusterrole.yaml grants Prometheus permissions to scrape Kubernetes metrics.

* ConfigMap ⚙️: prometheus-configmap.yaml provides Prometheus scraping configurations.

* Deployment 📦: prometheus-deployment.yaml manages Prometheus pods.

* Service 🌐: prometheus-service.yaml exposes Prometheus externally for accessing its dashboard.

#### The deployment is automated in the app-deployment.yaml workflow 🤖.

### 4️⃣ Access Prometheus Dashboard 🌐

#### Once deployed, Prometheus 📊 can be accessed via its external IP address.

#### 📤 Retrieve the external IP of the Prometheus service:

kubectl get svc -n monitoring

#### 🌐 Open your browser and navigate to http://<PROMETHEUS_EXTERNAL_IP>:9090.

#### 🤖 CI/CD Automation

#### GitHub Actions Workflows 🤖:

#### gke-provisioning.yaml:

* Automates Terraform 🛠️ provisioning of the GKE cluster.

* Runs on pushes to the main branch or manual triggers.

#### app-deployment.yaml:

* 🐳 Builds the Docker image and deploys the app and Prometheus 📊.

* Executes on updates to application code or Kubernetes manifests 📋.

### 🔄 Continuous Deployment:

#### Any changes pushed to the repository 📤 are automatically deployed, ensuring up-to-date infrastructure and applications.

#### 📝 Summary

##### This project demonstrates:

* 🛠️ Automated infrastructure provisioning with Terraform.

* 🌐 Web app deployment with Kubernetes.

* 📊 Real-time monitoring using Prometheus.

* 🤖 Streamlined CI/CD pipelines with GitHub Actions.

### By following this guide, you can ensure reliable deployment and monitoring of your 🌐 web application on GKE ☁️.