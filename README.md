# CloudDevOps Graduation Project
## NTI x iVolve DevOps Training Track

---

## 📋 Project Overview
This project demonstrates a complete end-to-end DevOps pipeline for a Python Flask web application, implementing modern DevOps practices including Infrastructure as Code, Configuration Management, Containerization, Container Orchestration, and CI/CD automation.

---

## 🏗️ Architecture Overview
Developer → GitHub → Jenkins CI → ECR → ArgoCD → Kubernetes (EKS)
↓
Trivy Scan
↓
Docker Build
↓
Push to ECR
↓
Update K8s Manifests
↓
ArgoCD Auto-Sync to EKS

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **GitHub** | Source code management |
| **Docker** | Containerization |
| **Terraform** | AWS Infrastructure provisioning |
| **Ansible** | Server configuration management |
| **Kubernetes (EKS)** | Container orchestration |
| **Jenkins** | CI pipeline automation |
| **ArgoCD** | CD - GitOps deployment |
| **Trivy** | Container security scanning |
| **AWS ECR** | Container registry |
| **AWS EKS** | Managed Kubernetes service |

---

## 📁 Project Structure

    CloudDevOpsProject/
    ├── docker/
    │   ├── app.py
    │   ├── requirements.txt
    │   ├── Dockerfile
    │   ├── static/
    │   └── templates/
    ├── terraform/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │   └── modules/
    │       ├── network/
    │       ├── server/
    │       ├── eks/
    │       └── ecr/
    ├── ansible/
    │   ├── playbook.yml
    │   ├── ansible.cfg
    │   ├── inventory/
    │   └── roles/
    │       ├── java/
    │       ├── jenkins/
    │       ├── docker/
    │       └── trivy/
    ├── kubernetes/
    │   ├── namespace.yaml
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── ingress.yaml
    ├── jenkins/
    │   ├── Jenkinsfile
    │   └── shared-library/
    │       └── vars/
    ├── argocd/
    │   └── application.yaml
    └── README.md

---

## 1️⃣ Application

Simple Python Flask web application showing NTI x iVolve graduation project page.

### Features:
- Displays company offices worldwide
- Responsive design
- Runs on port 5000

### Run Locally:
```bash
cd docker
docker build -t final-project .
docker run -p 5000:5000 final-project
```

### Screenshot:
[ADD SCREENSHOT: App running in browser]

---

## 2️⃣ Docker

### Dockerfile:
```dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python3", "app.py"]
```

### Screenshot:
[ADD SCREENSHOT: Docker build output]

---

## 3️⃣ Terraform - AWS Infrastructure

### Resources Created:

#### Network Module:
- VPC (10.0.0.0/16)
- 2 Public Subnets (us-east-1a, us-east-1b)
- 2 Private Subnets (us-east-1a, us-east-1b)
- Internet Gateway
- NAT Gateway
- Public & Private Route Tables
- Network ACL

#### Server Module:
- EC2 t3.micro for Jenkins
- Security Group (ports 22, 8080)

#### EKS Module:
- EKS Cluster v1.30
- Node Group (2 x t3.micro)
- IAM Roles and Policies

#### ECR Module:
- Container Registry
- Lifecycle Policy (keep last 5 images)

### Commands:
```bash
cd terraform
terraform init
terraform plan
terraform apply
terraform destroy
```

### Screenshot:
[ADD SCREENSHOT: terraform apply output]
[ADD SCREENSHOT: AWS Console - VPC]
[ADD SCREENSHOT: AWS Console - EKS Cluster]
[ADD SCREENSHOT: AWS Console - EC2 Instance]
[ADD SCREENSHOT: AWS Console - ECR Repository]

---

## 4️⃣ Ansible - Configuration Management

### Roles:
- **java**: Installs OpenJDK 21
- **jenkins**: Installs and configures Jenkins
- **docker**: Installs Docker CE
- **trivy**: Installs Trivy security scanner

### Run Playbook:
```bash
cd ansible
ansible-playbook -i "EC2_IP," -u ubuntu \
  --private-key ~/.ssh/clouddevops-key.pem \
  playbook.yml
```

### Screenshot:
[ADD SCREENSHOT: Ansible playbook output]
[ADD SCREENSHOT: Jenkins running on EC2]

---

## 5️⃣ Kubernetes - Container Orchestration

### Resources:
- Namespace: ivolve
- Deployment: 2 replicas
- Service: LoadBalancer type
- Ingress: nginx ingress controller

### Commands:
```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml
kubectl get pods -n ivolve
kubectl get service -n ivolve
```

### Screenshot:
[ADD SCREENSHOT: kubectl get pods -n ivolve]
[ADD SCREENSHOT: kubectl get nodes]
[ADD SCREENSHOT: App accessible via LoadBalancer URL]

---

## 6️⃣ Jenkins CI Pipeline

### Pipeline Stages:
1. **Build Image** → Build Docker image tagged with build number
2. **Scan Image** → Trivy security scan for HIGH/CRITICAL vulnerabilities
3. **Push Image** → Push to AWS ECR
4. **Delete Image Locally** → Clean up local image
5. **Update Manifests** → Update deployment.yaml with new image tag
6. **Push Manifests** → Push updated manifests to GitHub

### Shared Library:
Located in `jenkins/shared-library/vars/`
Each stage uses a reusable Groovy function.

### Screenshot:
[ADD SCREENSHOT: Jenkins pipeline success]
[ADD SCREENSHOT: Pipeline stages view]
[ADD SCREENSHOT: ECR image pushed]

---

## 7️⃣ ArgoCD - Continuous Deployment

### Configuration:
- Monitors GitHub repository
- Auto-syncs when manifests change
- Deploys to Kubernetes automatically
- Self-healing enabled

### Setup:
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f argocd/application.yaml
```

### Screenshot:
[ADD SCREENSHOT: ArgoCD UI showing Synced status]
[ADD SCREENSHOT: ArgoCD application tree]

---

## 🔄 Complete CI/CD Flow

Developer pushes code to GitHub
Jenkins detects change
Jenkins builds Docker image
Trivy scans image for vulnerabilities
Image pushed to AWS ECR
Local image deleted
deployment.yaml updated with new tag
Updated manifest pushed to GitHub
ArgoCD detects manifest change
ArgoCD deploys new version to EKS
Users see updated application ✅


---

## 📊 Results

| Component | Status |
|---|---|
| Application | ✅ Running |
| Docker Image | ✅ Built & Pushed to ECR |
| AWS Infrastructure | ✅ Created with Terraform |
| Jenkins Configuration | ✅ Configured with Ansible |
| Kubernetes Deployment | ✅ Running on EKS |
| CI Pipeline | ✅ Fully Automated |
| CD with ArgoCD | ✅ Auto-syncing |
| Security Scanning | ✅ Trivy integrated |

---

## 🚀 Setup Instructions

### Prerequisites:
- AWS Account
- AWS CLI configured
- Terraform installed
- kubectl installed
- Docker Desktop

### Steps:
```bash
# 1. Clone repository
git clone https://github.com/momagdyy/CloudDevOpsProject.git
cd CloudDevOpsProject

# 2. Create infrastructure
cd terraform
terraform init
terraform apply

# 3. Configure Jenkins EC2
cd ../ansible
ansible-playbook -i "EC2_IP," -u ubuntu \
  --private-key ~/.ssh/key.pem playbook.yml

# 4. Deploy to Kubernetes
cd ..
kubectl apply -f kubernetes/

# 5. Setup ArgoCD
kubectl apply -f argocd/application.yaml
```

---

## 👨‍💻 Author
Mohamed Magdy
NTI DevOps Training Track
iVolve Technologies Internship
2026