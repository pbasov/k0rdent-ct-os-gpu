# OpenStack Standalone CP NoLNI GPU Chart

A Helm chart for deploying k0s clusters on OpenStack with GPU support.

## Overview

This chart deploys a k0s cluster on OpenStack with bootstrapped control plane nodes and optional GPU worker nodes. It supports multiple GPU types including L4, L40, H100, H200, B200, and B200VM.

## Key Features

- **Consolidated GPU Configuration**: All GPU types are managed through a unified configuration structure
- **Conditional GPU Rendering**: GPU resources are only created when replicas > 0
- **OIDC Integration**: Optional OIDC authentication configuration
- **Security Contexts**: Built-in pod security contexts and resource limits
- **Schema Validation**: Complete JSON schema validation for all configuration options

## Configuration

### Basic Configuration

```yaml
# Control plane and worker nodes
controlPlaneNumber: 3
workersNumber: 3
ingressNumber: 2

# Identity configuration (required)
identityRef:
  name: "my-openstack-secret"
  cloudName: "openstack"
  region: "RegionOne"
```

### GPU Configuration

```yaml
# GPU node types and replicas
gpuTypes:
  l4:
    replicas: 2
  h100:
    replicas: 1
  # ... other GPU types

# GPU machine specifications
gpu:
  sshPublicKey: "my-ssh-key"
  image:
    filter:
      name: "ubuntu-gpu-image"
  types:
    l4:
      flavor: "gpu.l4.large"
    h100:
      flavor: "gpu.h100.xlarge"
    # ... other GPU flavors
```

### OIDC Configuration

```yaml
k0s:
  oidc:
    enabled: true
    clientId: "k8s-client"
    issuerUrl: "https://your-oidc-provider.com"
    groupsClaim: "groups"
    usernameClaim: "name"
```

### Security and Resources

```yaml
security:
  podSecurityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000

resources:
  controlPlane:
    requests:
      cpu: "2"
      memory: "4Gi"
    limits:
      cpu: "4"
      memory: "8Gi"
```

## Template Structure

The chart uses a consolidated template structure:

- `gpu-resources.yaml`: Single template for all GPU types using conditional rendering
- `_helpers.tpl`: Generic helper functions for naming and configuration
- Conditional resource creation based on replica counts

## Validation

The chart includes comprehensive JSON schema validation in `values.schema.json` covering:

- GPU type configurations
- OIDC settings
- Security contexts
- Resource limits
- OpenStack-specific configurations

## Usage

1. Configure your `values.yaml` with the required OpenStack credentials and desired GPU types
2. Install the chart:

```bash
helm install my-cluster . -f values.yaml
```

## Requirements

- OpenStack cluster with GPU-enabled compute nodes
- k0s version v1.32.3+k0s.0 or compatible
- Cluster API providers for OpenStack
- k0smotron for k0s control plane management

## Version

Chart version: 0.1.6
App version: v1.32.3+k0s.0