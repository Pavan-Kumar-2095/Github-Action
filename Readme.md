# GitHub Actions CI/CD Pipeline using Docker, Azure Container Registry & Azure Container Instance


## Project Overview

This project demonstrates a complete end-to-end **CI/CD (Continuous Integration and Continuous Deployment)** pipeline for deploying a Dockerized web application using:

- GitHub Actions
- Docker
- Azure Container Registry (ACR)
- Azure Container Instance (ACI)
- Nginx Web Server

The purpose of this project is to automate the complete application deployment process.

Instead of manually building Docker images and uploading applications to servers, the entire process is automated.

Whenever new code is pushed to GitHub:

```
Developer
    |
    |
    | git push
    ↓
GitHub Repository
    |
    |
    ↓
GitHub Actions Workflow
    |
    |
    | Docker Build
    ↓
Azure Container Registry
    |
    |
    | Pull Docker Image
    ↓
Azure Container Instance
    |
    |
    ↓
Nginx Web Server
    |
    |
    ↓
Live Website
```

---

## Project ScreenShots

## 1. Application

![Application](assets/Application.png)

---

## 2. GitHub Actions Workflow

![GitHub Actions](assets/Github_Action.png)

---

## 3. Azure Container Registry

![Azure Container Registry](assets/Azure_acr.png)

---

## 4. Azure Container Instance

![Azure Container Instance](assets/Azure_ACI.png)


---

# How This Project Works

The deployment process follows these steps:

## Step 1: Developer Pushes Code

Developer modifies application files:

```
index.html
style.css
script.js
```

Then pushes changes:

```bash
git push
```

---

## Step 2: GitHub Actions Starts

GitHub detects the push event.

The workflow file:

```
.github/workflows/build.yml
```

runs automatically.

---

## Step 3: Docker Image Creation

GitHub Actions creates a Docker image.

The image contains:

```
Website Files
+
Nginx Web Server
+
Container Configuration
```

---

## Step 4: Push Image to Azure

The Docker image is uploaded to Azure Container Registry.

Example:

```
demoactionacr.azurecr.io/my-website:<version>
```

---

## Step 5: Deploy Container

Azure Container Instance downloads the Docker image and starts the container.

The website becomes available publicly.

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| HTML | Website structure |
| CSS | Website styling |
| JavaScript | Website functionality |
| Docker | Application containerization |
| Nginx | Web server |
| GitHub Actions | CI/CD automation |
| Azure Container Registry | Docker image storage |
| Azure Container Instance | Cloud container hosting |
| Azure CLI | Azure resource management |

---

# Project Structure

After completing the setup, the project will look like:

```
Github-Action

│
├── .github
│   |
│   └── workflows
│       |
│       └── build.yml
│
├── assets
│   |
│   ├── Application.png
│   ├── Github_Action.png
│   ├── Azure_acr.png
│   └── Azure_ACI.png
│
├── Dockerfile
│
├── index.html
│
├── style.css
│
├── script.js
│
└── README.md

```

---

## Prerequisites

- Git
- Docker Desktop
- Azure CLI
- GitHub account
- Azure account

## Clone the Repository

```bash
git clone https://github.com/Pavan-Kumar-2095/Github-Action
cd Github-Action
```

# Step 4: Test Docker Locally

Before deploying to Azure, test locally.



## Build Docker Image

Run:

```bash
docker build -t my-website .
```

Docker creates:

```
my-website
```

image.

---

## Check Docker Images

```bash
docker images
```

Example:

```
REPOSITORY

my-website

TAG

latest
```

---

## Run Container

```bash
docker run -p 8080:80 my-website
```

Explanation:

```
8080 = Local machine port

80 = Container port
```

---

Open browser:

```
http://localhost:8080
```

Expected result:

```
My Azure CI/CD Demo 🚀
```

---

# Stop Container

Find container:

```bash
docker ps
```

Stop:

```bash
docker stop <container-id>
```

---

# Local Testing Completed ✅

The application is now running successfully inside Docker.

Next steps:

- Create Azure resources
- Upload Docker image
- Configure GitHub Actions
- Automate deployment
---

# Step 5: Login to Azure

Azure CLI is used to create and manage Azure resources.

Login to your Azure account:

```bash
az login
```

A browser window will open.

Sign in using your Azure account.

---

## Verify Azure Account

Check the active subscription:

```bash
az account show
```

Example output:

```json
{
  "name": "Azure Subscription",
  "state": "Enabled"
}
```

---

## Get Subscription ID

The subscription ID is required for GitHub Actions authentication.

Run:

```bash
az account show \
--query id \
--output tsv
```

Example:

```
xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Save this value.

---

# Step 6: Create Azure Resource Group

A resource group is a logical container that stores Azure resources.

This project uses:

```
Resource Group Name:

myResourceGroup
```

Create resource group:

```bash
az group create \
--name myResourceGroup \
--location centralindia
```

Example output:

```json
{
  "name": "myResourceGroup",
  "location": "centralindia"
}
```

---

## Verify Resource Group

```bash
az group list \
--output table
```

Expected:

```
Name              Location

myResourceGroup   centralindia
```

---

# Step 7: Create Azure Container Registry (ACR)

## What is Azure Container Registry?

Azure Container Registry is a private Docker image repository.

It stores Docker images securely before deployment.

Architecture:

```
Docker Image
      |
      ↓
Azure Container Registry
      |
      ↓
Azure Container Instance

```

---

## Create Container Registry

Run:

```bash
az acr create \
--resource-group myResourceGroup \
--name demoactionacr \
--sku Basic
```

Explanation:

```
demoactionacr
↓
Registry Name


Basic
↓
Pricing Tier

```

---

## Login to Azure Container Registry

```bash
az acr login \
--name demoactionacr
```

Successful output:

```
Login Succeeded
```

---

## Registry URL

Your registry URL will be:

```
demoactionacr.azurecr.io
```

This URL will be used by Docker and GitHub Actions.

---

# Step 8: Push Docker Image Manually

Before automation, test pushing an image manually.



## Build Docker Image

```bash
docker build \
-t my-website .
```

---

## Tag Docker Image

Docker images need the Azure registry address.

Command:

```bash
docker tag my-website \
demoactionacr.azurecr.io/my-website:v1
```

Image format:

```
<registry>/<image-name>:<tag>
```

Example:

```
demoactionacr.azurecr.io/my-website:v1
```

---

## Push Image to ACR

```bash
docker push \
demoactionacr.azurecr.io/my-website:v1
```

Example output:

```
Pushed successfully
```

---

## Verify Image in ACR

List repositories:

```bash
az acr repository list \
--name demoactionacr \
--output table
```

Expected:

```
Result

my-website
```

---

# Step 9: Enable Azure Container Registry Authentication

GitHub Actions needs permission to pull images from ACR.

Enable admin login:

```bash
az acr update \
--name demoactionacr \
--admin-enabled true
```

---

## Get ACR Credentials

Run:

```bash
az acr credential show \
--name demoactionacr
```

Example:

```json
{
 "username":"demoactionacr",
 "passwords":[
   {
    "value":"xxxxxxxx"
   }
 ]
}
```

Save:

```
ACR Username

ACR Password
```

These values will be added to GitHub Secrets.

---

# Step 10: Create Azure Service Principal

## What is Service Principal?

A Service Principal allows external applications like GitHub Actions to securely access Azure resources.

Instead of storing personal Azure login details, GitHub uses this identity.

Flow:

```
GitHub Actions
        |
        |
Service Principal
        |
        |
Azure Resources

```

---

## Create Service Principal

First get subscription ID:

```bash
az account show \
--query id \
--output tsv
```

Create service principal:

```bash
az ad sp create-for-rbac \
--name github-actions-azure \
--role contributor \
--scopes /subscriptions/<SUBSCRIPTION_ID>
```

Replace:

```
<SUBSCRIPTION_ID>
```

with your subscription ID.

---

Example output:

```json
{
 "clientId": "xxxxxxxx",
 "clientSecret": "xxxxxxxx",
 "subscriptionId": "xxxxxxxx",
 "tenantId": "xxxxxxxx"
}
```

Save:

```
clientId

clientSecret

subscriptionId

tenantId

```

---

# Step 11: Push the Code to Your GitHub Repository

After completing the project, push the code to your GitHub repository.

If you haven't created a repository yet, create a new repository on GitHub first, then add it as the remote and push your code.
```bash
git add .
git commit -m "Initial commit"
git push origin main
```

---

# Step 12: Configure GitHub Secrets

GitHub Actions requires Azure credentials.

Go to:

```
GitHub Repository
        ↓
Settings
        ↓
Secrets and Variables
        ↓
Actions
        ↓
New Repository Secret

```
---

###  Add the following secrets:


| Secret Name | Value |
|-|-|
| AZURE_CLIENT_ID | Service Principal clientId |
| AZURE_CLIENT_SECRET | Service Principal clientSecret |
| AZURE_SUBSCRIPTION_ID | Azure Subscription ID |
| AZURE_TENANT_ID | Azure Tenant ID |
| RESOURCE_GROUP | myResourceGroup |
| ACR_NAME | demoactionacr |
| ACR_LOGIN_SERVER | demoactionacr.azurecr.io |
| ACR_USERNAME | ACR username |
| ACR_PASSWORD | ACR password |
| ACI_NAME | mywebsite-container |

---

# Step 13: GitHub Actions Workflow (build.yml)

GitHub Actions uses workflow files to automate CI/CD processes.

The workflow file is stored inside: `.github/workflows/build.yml`

This file defines the complete deployment pipeline

---

# CI/CD Configuration Completed ✅

The pipeline is now ready.

Next:

- Trigger deployment
- Verify GitHub Actions execution
- Access the Azure hosted website


---


# Step 14: Updating the Website

To deploy a new version:

Modify:

```
index.html

style.css

script.js

```

Example:

Change:

```html
<h1>
My Azure CI/CD Demo 🚀
</h1>
```

to:

```html
<h1>
My Updated Azure Website 🚀
</h1>
```

---



# Step 15: GitHub Actions Execution

After pushing code, GitHub Actions automatically starts.

Go to:

```
GitHub Repository
↓
Actions Tab

```

You will see:

```
Build Deploy Website

Running
```

---

# Pipeline Execution Flow

The workflow executes the following steps:

```
Checkout Code
        ↓
Azure Login
        ↓
Login ACR
        ↓
Docker Build
        ↓
Docker Push
        ↓
Create Azure Container Instance
        ↓
Application Deployment Complete

```
---

# Step 16: Verify Azure Container Instance

After GitHub Actions completes successfully, verify the container.

---

## Check Container Status

Run:

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query instanceView.state
```

Expected:

```
Running
```

---

# Get Container Details

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container
```

---

# Step 17: Get Website URL

Azure assigns a DNS name automatically.

Run:

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query ipAddress.fqdn
```

Example output:

```
my-website-demo.centralindia.azurecontainer.io
```

---

Open browser:

```
http://my-website-demo.centralindia.azurecontainer.io
```

The deployed website should appear.

---

# Complete Project Result

After completing this project:

✅ Static website created  
✅ Docker image created  
✅ Docker image stored in Azure Container Registry  
✅ GitHub Actions CI/CD pipeline configured  
✅ Azure Container Instance deployed  
✅ Automatic deployment enabled  
✅ Versioned Docker images implemented  

---

## Pavan Kumar

GitHub:
```
https://github.com/Pavan-Kumar-2095
```

LinkedIn:

```
https://www.linkedin.com/in/pavan-kumar-107655297/
```

LeetCode:

```
https://leetcode.com/u/Pavan_Kumar-7070/
```

---

# ⭐ Conclusion


This project demonstrates a practical DevOps workflow by integrating GitHub Actions, Docker, Azure Container Registry, and Azure Container Instance to automate application deployment.

It showcases key DevOps concepts including CI/CD automation, containerization, cloud deployment, secure credential management with GitHub Secrets, providing a solid foundation for production-oriented cloud-native applications.