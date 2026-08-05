# Prerequisites

Before getting started, ensure you have the required accounts, tools, and basic AWS knowledge to successfully reproduce this project.

---

# AWS Requirements

## AWS Account

Create an AWS account if you don't already have one.

> **Note:** This project provisions cloud infrastructure on AWS and may incur charges. Remember to clean up resources after completing the implementation.

---

## IAM User

Avoid using the AWS root account for day-to-day operations.

Create an IAM user with the required permissions and use it for all AWS-related tasks.

Recommended permissions:

- AdministratorAccess *(for learning purposes)*
- Alternatively, follow the principle of least privilege by granting only the permissions required for this project.

---

## AWS Region

This project was implemented in:

```text
us-east-1 (N. Virginia)
```

Using the same region helps avoid compatibility issues and keeps the implementation consistent.

---

# Local Machine Requirements

The project can be completed using:

- macOS
- Linux
- Windows (WSL recommended)

If you prefer not to use your local machine, you can provision an Ubuntu EC2 instance and perform the implementation remotely.

Recommended EC2 configuration:

| Property | Value |
|----------|-------|
| AMI | Ubuntu |
| Instance Type | t2.large (or higher) |
| Public IP | Enabled |
| Security Group | Allow SSH (22) |

---

# Required Tools

Install the following tools before starting the project.

| Tool | Purpose |
|------|---------|
| Git | Clone the repository |
| Docker | Build and run containers |
| Docker Compose | Run multi-container applications locally |
| Terraform | Provision AWS infrastructure |
| AWS CLI | Authenticate and manage AWS resources |
| kubectl | Interact with the Kubernetes cluster |
| eksctl | Configure and manage Amazon EKS |
| Helm | Install the AWS Load Balancer Controller |

---

# Verify Installations

After installing each tool, verify the installation using the following commands.

## Git

```bash
git --version
```

---

## Docker

```bash
docker --version
```

---

## Docker Compose

```bash
docker compose version
```

---

## Terraform

```bash
terraform version
```

---

## AWS CLI

```bash
aws --version
```

---

## kubectl

```bash
kubectl version --client
```

---

## eksctl

```bash
eksctl version
```

---

## Helm

```bash
helm version
```

---

# Configure AWS CLI

Generate an Access Key for your IAM user.

Navigate to:

```text
AWS Console
→ IAM
→ Users
→ Security Credentials
→ Create Access Key
→ Command Line Interface (CLI)
```

Store the generated credentials securely.

Configure the AWS CLI:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region
Output Format
```

Terraform and the AWS CLI will use these credentials to authenticate with your AWS account.

---

# Clone the Repository

Clone your fork of the OpenTelemetry Demo repository.

```bash
git clone <your-fork-url>
```

Move into the project directory.

```bash
cd opentelemetry-demo
```

---

# Project Structure

The implementation is divided into the following stages.

1. Run the application locally
2. Containerize selected microservices
3. Deploy locally using Docker Compose
4. Provision AWS infrastructure using Terraform
5. Deploy the application to Amazon EKS
6. Configure AWS Load Balancer Controller and Ingress
7. Implement CI using GitHub Actions
8. Implement GitOps Continuous Delivery using ArgoCD

Each stage is documented individually under the `docs/` directory.

---

# Estimated Cost

The infrastructure created in this project includes Amazon EKS and supporting AWS resources.

Although costs vary depending on usage and region, running the complete environment for an extended period will incur AWS charges.

To avoid unnecessary costs:

- Destroy Terraform-managed resources after completing the project.
- Delete Kubernetes resources when no longer required.
- Remove unused Docker images and containers.

Detailed cleanup steps are available in [CLEANUP.md](CLEANUP.md).

---

# Next Step

Once all prerequisites have been completed, continue with:

**[LOCAL-SETUP.md](LOCAL-SETUP.md)**

In the next section, we'll clone the repository and run the Astronomy Shop application locally using Docker Compose before deploying it to Kubernetes.