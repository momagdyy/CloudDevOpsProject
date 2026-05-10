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
<img width="1913" height="962" alt="Screenshot 2026-05-09 150151" src="https://github.com/user-attachments/assets/3522de2d-be70-431e-a347-46f0b89b1065" />

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
<img width="923" height="426" alt="Screenshot 2026-05-09 181919" src="https://github.com/user-attachments/assets/4a8d29a0-d9ea-440a-beb3-647cfe9d41ce" />
<img width="867" height="426" alt="Screenshot 2026-05-09 154939" src="https://github.com/user-attachments/assets/f2296f9c-a475-41ed-9692-3cab4a773fbd" />
<img width="1918" height="866" alt="Screenshot 2026-05-09 175650" src="https://github.com/user-attachments/assets/fe100e68-973f-464e-9b71-39e7cd10b405" />
<img width="1918" height="887" alt="Screenshot 2026-05-09 175328" src="https://github.com/user-attachments/assets/bfed4e06-c930-4d5f-8258-d03da6b2cc7e" />
<img width="1917" height="812" alt="Screenshot 2026-05-09 183408" src="https://github.com/user-attachments/assets/3632a059-4b05-4743-9e37-0dba82415a68" />
<img width="1558" height="747" alt="Screenshot 2026-05-09 181444" src="https://github.com/user-attachments/assets/82a608f3-443c-4c8c-ae3c-fa2c3e5ed295" />


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
<img width="1456" height="587" alt="Screenshot 2026-05-09 181643" src="https://github.com/user-attachments/assets/e01bf31b-636a-41e4-988f-03a8d531599e" />
<img width="1918" height="967" alt="Screenshot 2026-05-09 180453" src="https://github.com/user-attachments/assets/3c75e58a-eb38-4eb5-b64a-8333b4af0599" />

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
<img width="705" height="107" alt="Screenshot 2026-05-09 192430" src="https://github.com/user-attachments/assets/94a00097-4ac8-4e87-9390-0f647744a58b" />
<img width="797" height="122" alt="Screenshot 2026-05-09 192406" src="https://github.com/user-attachments/assets/46d1e6f7-3032-4f68-8da9-7086c3c99d90" />
<img width="1247" height="113" alt="Screenshot 2026-05-09 192452" src="https://github.com/user-attachments/assets/fdf62f29-4718-4839-a280-0fdaab4e492d" />
<img width="1917" height="952" alt="Screenshot 2026-05-09 193825" src="https://github.com/user-attachments/assets/56972283-6cfb-48c4-97f8-25dcda0cf703" />


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
<img width="1918" height="922" alt="Screenshot 2026-05-09 202027" src="https://github.com/user-attachments/assets/e0dfbacd-7625-41d1-b2bd-ed5c93e3ef17" />
<img width="1918" height="860" alt="Screenshot 2026-05-09 202223" src="https://github.com/user-attachments/assets/b39fe32d-c58f-4fa0-b101-4b6ccf4355b6" />

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
<img width="1910" height="904" alt="Screenshot 2026-05-07 013227" src="https://github.com/user-attachments/assets/4c8e3146-3e85-4ccc-b6d1-3944df61a0d1" />
<img width="1914" height="968" alt="Screenshot 2026-05-07 013156" src="https://github.com/user-attachments/assets/180aa792-db24-4675-8a4f-de31711b9f96" />


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
