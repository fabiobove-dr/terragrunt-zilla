# 🦕🌍 Terragrunt Zilla


This repository contains Terraform configurations for managing the following modules:
1. Keycloak
---

## Overview
- **Terraform** is used to define and manage the Keycloak infrastructure.
- **Terragrunt** is used to manage multiple environments (e.g., `dev`, `prod`) and reduce code duplication.

---

## Repository Structure

```
├── modules/
│   └── keycloak/                # Terraform module for Keycloak resources
│       ├── main.tf              # Keycloak resources (users, roles, realms)
│       ├── variables.tf         # Variables for the Keycloak module
│       ├── outputs.tf           # Outputs from the Keycloak module
│       └── terraform.tfvars     # Default variables for the module, create this file
│
├── live/
│   ├── dev/
│       └── keycloak/            # Terragrunt configuration for the 'dev' environment
│           └── terragrunt.hcl
│   ├── prod/
│       └── keycloak/            # Terragrunt configuration for the 'prod' environment
│           └── terragrunt.hcl   
├── terraform.tfvars             # Global variables for all environments, if needed create this file
```

**Modules Directory (`modules/`)**
- This directory contains the Terraform module. It is the base for the environment configurations.

**Live Directory (`live/`)**
- This directory contains environment-specific configurations. Each environment (e.g., `dev`, `prod`) has its own folder with a `terragrunt.hcl` file that specifies inputs for the Terraform module.

---

## Setup and Prerequisites

Before you begin, ensure you have the following installed:

1. **Terraform**: Version 0.12 or higher.
2. **Terragrunt**: Version 0.24 or higher.
3. **Keycloak**: A running Keycloak instance to apply the configurations to.

## Variables and Customization
You can customize your setup by modifying the variables in the `terragrunt.hcl` and `terraform.tfvars` files.
Each environment can have different configurations by editing the inputs in the environment-specific `terragrunt.hcl`.


## Usage
```
cd live/prod
terragrunt plan
terragrunt apply -auto-approve 
```

Enjoy 👾