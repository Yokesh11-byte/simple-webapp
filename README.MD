# Web App Deployment and Prometheus Monitoring on GKE
This README outlines the steps for deploying your web app and Prometheus monitoring on Google Kubernetes Engine (GKE). The entire deployment process is automated using GitHub Actions and Terraform, ensuring a smooth and reliable CI/CD pipeline.

# Project Directory Structure
The project is organized as follows:

```
├── .github/
│   └── workflows/
│       ├── cluster-provisioning.yaml  # GitHub Actions workflow for provisioning GKE cluster
│       └── kubernetes-deployment.yaml  # GitHub Actions workflow for deploying app & Prometheus
├── manifests/
│   ├── deployment.yaml  # Web app Kubernetes deployment manifest
│   └── service.yaml  # Web app Kubernetes service manifest
├── prometheus/
│   ├── clusterRole.yaml  # ClusterRoleBinding for Prometheus
│   ├── prometheus-configmap.yaml  # Prometheus config map
│   ├── namespace.yaml  # Namespace for monitoring
│   ├── prometheus-deployment.yaml  # Prometheus deployment manifest
│   └── prometheus-service.yaml  # Prometheus service 
manifest
├── terraform/
│   ├── main.tf  # Terraform configuration for GKE provisioning
│   ├── backend.tf  # Terraform backend configuration
│   ├── outputs.tf  # Outputs of the Terraform provisioning
│   ├── variables.tf  # Terraform variables for GKE and infrastructure
│   └── terraform.tfvars  # Variable values for Terraform configuration
├── src/
│   └── index.html  # Web app source code
├── Dockerfile  # Dockerfile for building the web app container using Caddy base image
└── README.md  # This file
```

# Steps to Deploy Web App and Prometheus Monitoring
## 1.Terraform Provisioning for GKE and Infrastructure
The first GitHub Actions workflow, cluster-provisioning.yaml, provisions the necessary infrastructure in Google Cloud, including:

   * GKE Cluster: The Terraform configuration creates a GKE cluster for deploying your web app and Prometheus monitoring.

   * VPC and Networking: Required networking resources are provisioned to support the GKE cluster.
### Terraform Files:
* main.tf: Main configuration for provisioning the GKE cluster and associated resources.
* variables.tf: Defines the input variables for the Terraform configuration.
* terraform.tfvars: Contains the values for the variables defined in variables.tf.
* backend.tf: Configures the Terraform backend (e.g., for state management).
* outputs.tf: Defines the output values (e.g., GKE cluster details).

Run the Terraform provisioning by triggering the cluster-provisioning.yaml GitHub Actions workflow.

## 2. Web App Deployment
Once the GKE cluster is provisioned, the next step is to deploy the web app using Kubernetes.

## Dockerfile:
* Dockerfile: The Dockerfile in the root directory uses the Caddy base image to serve your web app, which is located in src/index.html.

The web app container will be built and pushed to a container registry during the deployment process.

## Kubernetes Manifests:
* deployment.yaml: Defines the deployment for your web app, ensuring that it is replicated and ready for scaling.
* service.yaml: Exposes the web app to the outside world by creating a Kubernetes service.

These files are located in the manifests/ folder.

The second GitHub Actions workflow, kubernetes-deployment.yaml, handles the deployment process. It applies the deployment.yaml and service.yaml files to your GKE cluster using kubectl.

## 3. Prometheus Monitoring Setup
Prometheus will be deployed to monitor your GKE cluster, with the following components:

## Prometheus Files:
* namespace.yaml: Creates the monitoring namespace for Prometheus and related resources.
* clusterrolebinding.yaml: Provides the necessary permissions for Prometheus to interact with the Kubernetes cluster.
* configmap.yaml: Defines the configuration for Prometheus.
* prometheus-deployment.yaml: Deploys the Prometheus pods in your GKE cluster.
* prometheus-service.yaml: Exposes Prometheus through a service to monitor the Kubernetes cluster.

These files are located in the prometheus/ folder.

The GitHub Actions pipeline will automatically apply these files to set up Prometheus monitoring for the GKE cluster after the web app is deployed.

## 4. GitHub Actions Pipelines
The CI/CD pipelines are defined in the .github/workflows/ directory:

* cluster-provisioning.yaml: This workflow provisions the GKE cluster and required networking resources using Terraform. It runs the Terraform commands (terraform init, terraform apply) to set up the infrastructure.
* kubernetes-deployment.yaml: After the infrastructure is ready, this workflow handles the deployment of the web app and Prometheus using kubectl. It builds the Docker image for your web app, pushes it to a container registry, and applies the Kubernetes manifests.

# 5. Monitor Prometheus
After the deployment, you can access Prometheus to monitor the cluster:

* Access Prometheus: Open your browser and navigate to http://<Prometheus-EXTERNAL-IP>:9090 to view the Prometheus dashboard.

# Continuous Deployment
The entire deployment process is fully automated through GitHub Actions. The pipeline triggers automatically on pushes to the main branch, ensuring that both the GKE infrastructure and application deployments are consistently deployed and monitored.
