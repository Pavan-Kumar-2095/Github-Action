# GitHub Actions CI/CD Pipeline using Docker, Azure Container Registry & Azure Container Instance

![Application](assets/Application.png)

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

# What is CI/CD?

## Continuous Integration (CI)

Continuous Integration is the practice of automatically building and validating application changes whenever developers push new code.

Example:

```
Developer writes code

        ↓

Push code to GitHub

        ↓

GitHub Actions starts

        ↓

Application is built automatically
```

---

## Continuous Deployment (CD)

Continuous Deployment automatically releases the updated application after successful build steps.

Example:

```
New Code

↓

Docker Image Created

↓

Image Stored in Azure

↓

Container Updated

↓

Application Available Online
```

---

# Project Architecture

```
                         Developer

                             |

                             |

                         git push

                             |

                             ↓


                    GitHub Repository


                             |

                             |

                    GitHub Actions Runner


                             |

                             |

                    Docker Image Build


                             |

                             ↓


              Azure Container Registry (ACR)


                             |

                             |

                 Docker Image Repository


                             |

                             ↓


             Azure Container Instance (ACI)


                             |

                             |

                    Nginx Web Server


                             |

                             ↓


                    Public Website

```

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

# Prerequisites

Before starting, install the following tools.

---

# 1. Install Git

Git is required to manage source code and push changes to GitHub.

Download:

```
https://git-scm.com/
```

Verify installation:

```bash
git --version
```

Example output:

```
git version 2.50.0
```

---

# 2. Install Docker Desktop

Docker is used to create and run containers.

Download:

```
https://www.docker.com/products/docker-desktop/
```

Verify:

```bash
docker --version
```

Example:

```
Docker version 28.0
```

---

# 3. Install Azure CLI

Azure CLI allows management of Azure resources from the terminal.

Download:

```
https://learn.microsoft.com/cli/azure/install-azure-cli
```

Verify:

```bash
az --version
```

---

# 4. Create Required Accounts

You need:

## GitHub Account

Required for:

- Repository creation
- GitHub Actions execution


## Azure Account

Required for:

- Azure Container Registry
- Azure Container Instance

Azure Free Account:

```
https://azure.microsoft.com/free/
```

---

# Step 1: Create Project Folder

Create a project directory:

```bash
mkdir Github-Action
```

Move inside:

```bash
cd Github-Action
```

Initialize Git:

```bash
git init
```

---

# Step 2: Create Website Application

The website contains:

```
index.html

style.css

script.js
```

---

# Create index.html

Create file:

```
index.html
```

Add the following code:

```html
<!DOCTYPE html>

<html>

<head>

<title>
Azure CI/CD Demo
</title>

<link rel="stylesheet" href="style.css">

</head>


<body>


<h1>
My Azure CI/CD Demo 🚀
</h1>


<p>
Deployed using GitHub Actions + Docker + Azure
</p>


<button onclick="hello()">
Click Me
</button>


<script src="script.js"></script>


</body>


</html>
```

---

# Create style.css

Create:

```
style.css
```

Add:

```css
body{

background:#202020;

color:white;

font-family:Arial;

text-align:center;

margin-top:100px;

}


h1{

color:#00ff99;

}
```

---

# Create script.js

Create:

```
script.js
```

Add:

```javascript
function hello(){

alert(
"Running from Azure Container Instance!"
);

}
```

---

# Step 3: Create Dockerfile

Dockerfile tells Docker how to create the application container.

Create:

```
Dockerfile
```

Add:

```dockerfile
FROM nginx:alpine


RUN rm -rf /usr/share/nginx/html/*


COPY . /usr/share/nginx/html


EXPOSE 80
```

---

# Understanding Dockerfile

## Base Image

```dockerfile
FROM nginx:alpine
```

Uses lightweight Nginx Linux image.

---

## Remove Default Website

```dockerfile
RUN rm -rf /usr/share/nginx/html/*
```

Deletes the default Nginx page.

---

## Copy Application Files

```dockerfile
COPY . /usr/share/nginx/html
```

Copies website files into Nginx directory.

---

## Expose Port

```dockerfile
EXPOSE 80
```

The website runs on HTTP port 80.

---

# Step 4: Test Docker Locally

Before deploying to Azure, test locally.

---

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

---

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

# Step 11: Create GitHub Repository

Create a new repository on GitHub.

Example:

```
Github-Action
```

Connect local project:

```bash
git remote add origin <github-repository-url>
```

Example:

```bash
git remote add origin https://github.com/username/Github-Action.git
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

Add the following secrets:

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

# Step 13: Create GitHub Actions Workflow

GitHub Actions workflows are stored inside:

```
.github/workflows
```

Create folders:

```bash
mkdir -p .github/workflows
```

Create file:

```
.github/workflows/build.yml
```

---

# Complete build.yml Configuration

Add:

```yaml
name: Build Deploy Website


on:

  push:

    branches:

      - main



jobs:


  build:


    runs-on: ubuntu-latest



    steps:



    - name: Checkout Code

      uses: actions/checkout@v4



    - name: Azure Login

      uses: azure/login@v2

      with:

        creds: |

          {

          "clientId":"${{ secrets.AZURE_CLIENT_ID }}",

          "clientSecret":"${{ secrets.AZURE_CLIENT_SECRET }}",

          "subscriptionId":"${{ secrets.AZURE_SUBSCRIPTION_ID }}",

          "tenantId":"${{ secrets.AZURE_TENANT_ID }}"

          }



    - name: Login Azure Container Registry

      run: |

        az acr login \
        --name ${{ secrets.ACR_NAME }}



    - name: Build Docker Image

      run: |

        docker build \
        -t ${{ secrets.ACR_LOGIN_SERVER }}/my-website:${{ github.sha }} .



    - name: Push Docker Image

      run: |

        docker push \
        ${{ secrets.ACR_LOGIN_SERVER }}/my-website:${{ github.sha }}



    - name: Deploy Azure Container Instance

      run: |


        az container create \

        --resource-group ${{ secrets.RESOURCE_GROUP }} \

        --name ${{ secrets.ACI_NAME }} \

        --image ${{ secrets.ACR_LOGIN_SERVER }}/my-website:${{ github.sha }} \

        --registry-login-server ${{ secrets.ACR_LOGIN_SERVER }} \

        --registry-username ${{ secrets.ACR_USERNAME }} \

        --registry-password ${{ secrets.ACR_PASSWORD }} \

        --dns-name-label my-website-demo \

        --ports 80 \

        --os-type Linux \

        --cpu 1 \

        --memory 1 \

        --restart-policy Always
```

---

# Understanding Workflow Steps

## Checkout Code

```yaml
actions/checkout@v4
```

Downloads repository code into the GitHub runner.

---

## Azure Login

```yaml
azure/login@v2
```

Authenticates GitHub Actions with Azure.

---

## Docker Build

```yaml
docker build
```

Creates a new Docker image.

---

## Docker Push

```yaml
docker push
```

Uploads the image to Azure Container Registry.

---

## Azure Container Deployment

```bash
az container create
```

Creates or updates the Azure Container Instance.

---

# Step 14: Commit Workflow

Add files:

```bash
git add .
```

Commit:

```bash
git commit -m "Add GitHub Actions CI/CD workflow"
```

Push:

```bash
git push
```

---

# CI/CD Configuration Completed ✅

The pipeline is now ready.

Next:

- Trigger deployment
- Verify GitHub Actions execution
- Access the Azure hosted website


---

# Step 15: Push Code to GitHub

If the repository is not connected yet:

```bash
git remote add origin <github-repository-url>
```

Example:

```bash
git remote add origin https://github.com/username/Github-Action.git
```

---

## Check Git Remote

```bash
git remote -v
```

Example output:

```
origin  https://github.com/username/Github-Action.git
```

---

## Add All Files

```bash
git add .
```

---

## Commit Changes

```bash
git commit -m "Initial CI/CD setup"
```

---

## Rename Branch to Main

```bash
git branch -M main
```

---

## Push Code

```bash
git push -u origin main
```

---

# Step 16: GitHub Actions Execution

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

# Step 17: Understanding Docker Image Versioning

This project uses:

```yaml
${{ github.sha }}
```

as the Docker image tag.

The Git commit ID becomes the image version.

Example:

```
First Commit

my-website:a82bc12


Second Commit

my-website:f91de55


Third Commit

my-website:c72aa90

```

---

## Benefits of Image Versioning

### 1. Deployment Tracking

You can identify which code version is running.

Example:

```
Production:

my-website:f91de55

```

---

### 2. Rollback Support

If a new deployment fails:

```
Current:

my-website:c72aa90


Previous:

my-website:f91de55

```

The previous image can be deployed again.

---

### 3. Avoid Image Overwriting

Each deployment creates a unique image.

---

# Step 18: Verify Azure Container Instance

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

# Step 19: Get Website URL

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

# Step 20: Verify Container Port

The application uses Nginx on port 80.

Check:

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query ipAddress.ports
```

Expected:

```json
[
 {
   "port":80,
   "protocol":"TCP"
 }
]
```

---

# Step 21: Check Container Logs

If the website is not working, check logs.

Command:

```bash
az container logs \
--resource-group myResourceGroup \
--name mywebsite-container
```

Example:

```
/docker-entrypoint.sh

Configuration complete

Starting nginx
```

---

# Step 22: Check Container Events

Events show:

- Image download status
- Container startup
- Errors
- Restart information


Run:

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query containers[0].instanceView.events
```

Example:

```
Pulling image

Started container

Container running

```

---

# Step 23: Updating the Website

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

## Commit Changes

```bash
git add .
```

---

```bash
git commit -m "Update website content"
```

---

Push:

```bash
git push
```

---

# Automatic Deployment Process

After pushing:

```
New Code

↓

GitHub Actions Trigger

↓

Docker Image Created

↓

New Image Uploaded to ACR

↓

ACI Downloads New Image

↓

Old Container Replaced

↓

Updated Website Available

```

No manual deployment is required.

---

# Step 24: Troubleshooting Guide

## Problem 1: GitHub Actions Azure Login Failed

### Possible Causes:

- Incorrect Azure secrets
- Wrong tenant ID
- Wrong subscription ID
- Service principal expired


### Solution:

Verify:

```
AZURE_CLIENT_ID

AZURE_CLIENT_SECRET

AZURE_TENANT_ID

AZURE_SUBSCRIPTION_ID

```

---

# Problem 2: Docker Push Failed

Error:

```
unauthorized authentication required
```

Solution:

Login again:

```bash
az acr login \
--name demoactionacr
```

Verify:

```bash
az acr repository list \
--name demoactionacr
```

---

# Problem 3: Container Not Starting

Check status:

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query instanceView.state
```

Check logs:

```bash
az container logs \
--resource-group myResourceGroup \
--name mywebsite-container
```

---

# Problem 4: Website Not Opening

Check:

## Container Status

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

## Check Port

```bash
az container show \
--resource-group myResourceGroup \
--name mywebsite-container \
--query ipAddress.ports
```

Expected:

```
80/TCP
```

---

# Step 25: Cleanup Azure Resources

When testing is complete, remove Azure resources.

Delete resource group:

```bash
az group delete \
--name myResourceGroup
```

Confirmation:

```
Are you sure you want to perform this operation?
```

Enter:

```
y
```

---

This deletes:

```
Azure Container Registry

Azure Container Instance

All Resources

```

---

# Project Limitations

Current implementation:

- No HTTPS certificate
- No custom domain
- No monitoring
- No automated rollback
- Single container deployment
- No security scanning

---

# Future Improvements

## 1. Add HTTPS

Possible solutions:

- Azure Front Door
- Application Gateway
- Managed Certificates

---

## 2. Add Monitoring

Integrate:

- Azure Monitor
- Application Insights
- Log Analytics

---

## 3. Add Security Scanning

Add:

- Docker image scanning
- Dependency vulnerability checks
- Container security policies

---

## 4. Use Azure Container Apps

Instead of ACI:

```
Azure Container Apps

        |

        |

Managed Scaling

        |

        |

Production Deployment

```

---

## 5. Kubernetes Deployment

For larger applications:

Use:

```
Azure Kubernetes Service (AKS)

```

Benefits:

- Multiple containers
- Auto scaling
- Load balancing
- Advanced deployment strategies

---

# Production Deployment Improvements

A production CI/CD pipeline can include:

```
Developer

↓

GitHub

↓

GitHub Actions

↓

Unit Testing

↓

Security Scan

↓

Docker Build

↓

ACR

↓

Deployment

↓

Monitoring

```

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


Final architecture:

```
Code Change

↓

Git Push

↓

GitHub Actions

↓

Docker Build

↓

Azure Container Registry

↓

Azure Container Instance

↓

Live Website

```

---

# Screenshots

## Application

```
assets/Application.png
```

![Application](assets/Application.png)


---

## GitHub Actions Workflow

```
assets/Github_Action.png
```

![GitHub Actions](assets/Github_Action.png)


---

## Azure Container Registry

```
assets/Azure_acr.png
```

![Azure Container Registry](assets/Azure_acr.png)


---

## Azure Container Instance

```
assets/Azure_ACI.png
```

![Azure Container Instance](assets/Azure_ACI.png)


---

# Author

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

This project demonstrates a complete real-world DevOps workflow using:

- GitHub Actions for automation
- Docker for containerization
- Azure Container Registry for image management
- Azure Container Instance for cloud deployment


It provides a foundation for building more advanced cloud-native applications with:

- Kubernetes
- Monitoring
- Security automation
- Production deployment strategies
