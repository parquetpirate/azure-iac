# Azure IaC - Terraform

Terraform project for provisioning Azure infrastructure — part of the **IaC with Terraform** course.

## Infrastructure Overview

This project deploys the following resources in Azure:

| Resource | Name | Details |
|---|---|---|
| Resource Group | `Resource_Group_Azure_IaC` | West US 2 region |
| Virtual Network | `vnet_terr_az` | `10.0.0.0/16` |
| Subnet | `subnet_trr_az` | `10.0.1.0/24` |
| Network Interface | `ni_trr_az` | Dynamic private IP |
| Linux VM | `vmaz` | Ubuntu 22.04 LTS, Standard_D2s_v3 |

> **Note:** The VNet (`/16`) provides a large address space, while the subnet (`/24`) defines a smaller range within it — this is a common pattern for network segmentation.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- An [Azure account](https://azure.microsoft.com/) with an active subscription

## Quick Start

### 1. Build the Docker image

```bash
docker build -t terraform-image:azure-iac .
```

### 2. Run the container

```bash
docker run -dit --name azure-iac -v ./IaC:/iac terraform-image:azure-iac /bin/bash
```

> On Windows, replace `./IaC` with the full path, e.g. `C:\path\to\IaC`.

### 3. Enter the container and install Azure CLI

```bash
docker exec -it azure-iac /bin/bash
```

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az upgrade
az login
```

### 4. Deploy with Terraform

```bash
terraform init
terraform validate
terraform plan -out azure_iac.tfplan
terraform apply azure_iac.tfplan
```

### 5. Visualize the dependency graph (optional)

```bash
terraform graph
```

Copy the output and paste it into [WebGraphviz](http://webgraphviz.com/) to see the resource dependency graph.

### 6. Destroy resources

```bash
terraform destroy
```

## File Structure

```
.
├── Dockerfile          # Ubuntu-based image with Terraform 1.15.5
├── IaC/
│   ├── main.tf         # Azure resources definition
│   └── provider.tf     # Terraform and AzureRM provider configuration
└── README.md
```

## Terraform Version

This project uses **Terraform 1.15.5** and the **AzureRM provider ~> 4.0**.
