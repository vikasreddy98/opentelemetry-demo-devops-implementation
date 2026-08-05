# Architecture

## Overview

The OpenTelemetry Demo (Astronomy Shop) is a cloud-native, microservices-based e-commerce application designed to demonstrate modern distributed application architectures.

Each business capability is implemented as an independent microservice, allowing services to be developed, deployed, and scaled independently while communicating over HTTP, gRPC, and TCP.

For this project, the application was deployed on **Amazon Elastic Kubernetes Service (EKS)** using **Docker**, **Terraform**, **Kubernetes**, **AWS Load Balancer Controller**, **GitHub Actions**, and **ArgoCD**.

---

## High-Level Architecture

> *Architecture provided by the OpenTelemetry Project.*

<p align="center">
    <img src="../screenshots/architecture.png" alt="OpenTelemetry Demo Architecture">
</p>

---

## Architecture Components

### Client Layer

The application can be accessed through:

- Web Browser
- React Native Mobile Application
- Load Generator (used for generating application traffic)

All incoming requests are routed through the **Frontend Proxy (Envoy)**.

---

### Frontend Layer

The **Frontend Proxy (Envoy)** acts as the application's entry point.

Responsibilities include:

- Receiving incoming HTTP requests
- Forwarding requests to the Frontend service
- Routing requests to backend microservices
- Acting as the API gateway

---

### Application Layer

The application consists of multiple independently deployable microservices.

| Service | Responsibility |
|----------|---------------|
| Frontend | User Interface |
| Product Catalog | Product information |
| Cart | Shopping cart management |
| Checkout | Checkout workflow |
| Currency | Currency conversion |
| Recommendation | Product recommendations |
| Payment | Payment processing |
| Shipping | Shipping calculations |
| Quote | Shipping quotes |
| Email | Order notifications |
| Accounting | Accounting operations |
| Fraud Detection | Fraud validation |
| Ad Service | Advertisement generation |
| Flagd | Feature flag management |

Each service performs a single responsibility and communicates with other services when required.

---

## Data Layer

The application uses multiple backend components.

| Component | Purpose |
|-----------|----------|
| PostgreSQL | Persistent relational database |
| Valkey | Distributed cache |
| Kafka | Asynchronous messaging queue |

These services provide storage, caching, and event-driven communication for various microservices.

---

## Communication Flow

The application uses multiple communication protocols.

| Protocol | Usage |
|-----------|-------|
| HTTP | Client communication |
| gRPC | Service-to-service communication |
| TCP | Kafka messaging |

Using gRPC for internal communication provides efficient, low-latency communication between services.

---

## Deployment Architecture

For this implementation, the application was deployed on Amazon Web Services using the following architecture:

```text
Internet
    │
    ▼
AWS Application Load Balancer
    │
    ▼
Ingress
    │
    ▼
Amazon EKS Cluster
    │
    ├── Frontend
    ├── Checkout
    ├── Product Catalog
    ├── Cart
    ├── Payment
    ├── Shipping
    ├── Recommendation
    ├── ...
    │
    ▼
PostgreSQL
Valkey
Kafka
```

---

## Infrastructure Components

| AWS Service | Purpose |
|-------------|----------|
| Amazon EKS | Kubernetes Cluster |
| Amazon EC2 | Worker Nodes |
| Amazon VPC | Network Isolation |
| Public & Private Subnets | Workload Segmentation |
| Internet Gateway | Internet Connectivity |
| NAT Gateway | Outbound Internet Access |
| Application Load Balancer | External Traffic Routing |
| IAM | Authentication & Authorization |

Infrastructure provisioning was automated using Terraform.

---

## Kubernetes Resources

The deployment uses the following Kubernetes resources:

- Namespace
- Deployments
- ReplicaSets
- Pods
- Services
- Service Accounts
- Ingress
- ConfigMaps
- Secrets

These resources work together to provide application deployment, networking, service discovery, and external access.

---

## CI/CD Architecture

The deployment pipeline follows a GitOps workflow.

```text
Developer

    │

GitHub Repository

    │

GitHub Actions

    │

Docker Hub

    │

ArgoCD

    │

Amazon EKS
```

Changes pushed to GitHub automatically trigger the CI pipeline, which builds and publishes updated container images.

ArgoCD continuously monitors the Git repository and synchronizes the Kubernetes cluster with the desired application state.

---

## Request Flow

A typical request follows this sequence:

```text
User

↓

Frontend Proxy (Envoy)

↓

Frontend

↓

Checkout

↓

Cart

↓

Product Catalog

↓

Payment

↓

Shipping

↓

Email

↓

Response
```

During checkout, multiple microservices collaborate to complete a single transaction, demonstrating a production-style distributed system architecture.

---

## Key Takeaways

- Microservices architecture with independent services
- Containerized using Docker
- Local development with Docker Compose
- Infrastructure provisioned using Terraform
- Application deployed on Amazon EKS
- External access through AWS Load Balancer Controller and Ingress
- CI using GitHub Actions
- GitOps deployment using ArgoCD
