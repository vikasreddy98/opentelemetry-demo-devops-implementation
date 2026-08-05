# Troubleshooting

## Overview

Throughout the implementation of this project, several issues were encountered across different stages of the deployment process.

Rather than treating these as setbacks, they served as valuable learning opportunities and helped build a better understanding of the tools and technologies involved.

This document summarizes the problems encountered, their root causes, the resolutions applied, and the lessons learned.

---

# Local Setup

## Issue: No Space Left on Device

### Error

```text
no space left on device
```

### Root Cause

The EC2 instance did not have sufficient disk space to download all Docker images required by the OpenTelemetry Demo application.

### Resolution

Attached additional storage to the EC2 instance (or increased the root EBS volume size) and reran:

```bash
docker compose up
```

### Lesson Learned

Distributed applications often require dozens of container images. Always verify available storage before pulling large image sets.

---

# Containerization

## Product Catalog Service

### Issue

```text
Environment Variable Not Set:
PRODUCT_CATALOG_PORT
```

### Root Cause

The Docker container expected the `PRODUCT_CATALOG_PORT` environment variable, but it was never defined inside the image.

### Resolution

Added the environment variable to the Dockerfile.

```Dockerfile
ENV PRODUCT_CATALOG_PORT=8088
```

Rebuilt the image using a new tag to avoid Docker layer caching.

### Lesson Learned

Applications that rely on environment variables should explicitly define defaults or document required runtime variables.

---

## Recommendation Service

### Issue

```text
Failed to build psutil
```

### Root Cause

The project referenced `psutil==5.9.6`, which does not support Python 3.12.

### Resolution

Updated the dependency.

```text
psutil>=6.0.0
```

Rebuilt the Docker image successfully.

### Lesson Learned

Dependency compatibility should always be verified when upgrading language runtimes.

---

# Terraform

## Issue

```text
The bucket namespace is shared by all users of the system.
Please select a different name and try again.
```

### Root Cause

Amazon S3 bucket names are globally unique.

The chosen bucket name already existed.

### Resolution

Updated the bucket name to a globally unique value and reapplied the configuration.

```bash
terraform apply
```

### Lesson Learned

Use unique naming conventions for globally scoped AWS resources such as S3 buckets.

---

# Continuous Integration

## Issue

```text
Node.js 20 is deprecated
```

### Root Cause

The GitHub Actions workflow referenced older GitHub Actions versions that targeted Node.js 20.

### Resolution

Updated the workflow.

| Old | New |
|------|-----|
| actions/checkout@v4 | actions/checkout@v5 |
| docker/setup-buildx-action@v1 | docker/setup-buildx-action@v3 |

### Lesson Learned

Keep GitHub Actions workflows updated to avoid deprecation issues.

---

## Issue

```text
Docker username and password required
```

### Root Cause

The workflow referenced incorrect GitHub Secret names.

### Resolution

Updated the workflow to reference the correct repository secrets.

### Lesson Learned

Repository secret names must exactly match those referenced in workflow files.

---

## Issue

```text
Process completed with exit code 128
```

### Root Cause

The GitHub Token variable name was incorrect.

### Resolution

Corrected the GitHub Token variable name used in the workflow.

### Lesson Learned

Authentication failures often result from simple configuration mismatches rather than tooling issues.

---

# Summary

The implementation involved troubleshooting issues across multiple stages, including:

- Local environment preparation
- Docker containerization
- Dependency compatibility
- Terraform infrastructure provisioning
- GitHub Actions workflow configuration

Each issue provided valuable insight into the operational aspects of modern DevOps tooling and reinforced the importance of careful configuration, version compatibility, and systematic debugging.