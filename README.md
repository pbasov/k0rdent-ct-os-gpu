# OpenStack Standalone CP NoCNI GPU Chart

A Helm chart for deploying k0s clusters on OpenStack without CNI (Container Network Interface) pre-installed, with GPU support.

## Overview

This chart deploys a k0s cluster on OpenStack with bootstrapped control plane nodes and optional GPU worker nodes. As a "NoCNI" template, it allows you to install your own CNI solution after cluster creation. It supports multiple GPU types including L4, L40, H100, H200, B200, and B200VM.

- **No CNI Pre-installed**: Deploy your preferred CNI solution post-installation