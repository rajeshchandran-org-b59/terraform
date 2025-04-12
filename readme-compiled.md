# Learn Terraform

## Non-Functional Requirements (NFR)
- Code should be DRY.
- Credentials should not be hardcoded.
- Re-run of the script should not fail.
- Code should be multi-environment compatible.

---

Terraform is a very powerful Infrastructure as Code (IaC) tool that can be managed via HCL (HashiCorp Configuration Language).

### Key Points to Note When Using Terraform
1. Terraform only recognizes files ending with `.tf`, `.auto.tfvars`, or `.tfvars` as Terraform files.
2. Terraform code can be written in a single file or split across multiple files.
3. Terraform loads files in alphabetical order and compiles them logically.
4. Terraform is all about blocks `{}`.

---

## Common Terraform Commands
1. `terraform init`
2. `terraform plan`
3. `terraform apply`
4. `terraform destroy`

### How to Install Terraform
Refer to the [official installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform).

---

## Key Concepts

### Indentation
Unlike Ansible/YAML, HCL is not indentation-specific. However, for readability, follow standard spacing.

---

### EC2 Instance Authorization to AWS Cloud
1. Provision an IAM Role for the EC2 service.
2. Assign the necessary permissions to the IAM Role (e.g., Full Access).
3. Attach the IAM Role to the EC2 instance or Jenkins.

This ensures your EC2 instance has the required authorization to interact with AWS Cloud.

---

### Terraform Rule of Thumb
1. Align all provisioning, updates, and maintenance through Terraform only.
2. Manual changes should not be tolerated.
3. If manual changes are made to a Terraform-managed resource, import the changes into Terraform.

---

### Terraform Drift
1. Drift occurs when a resource managed by Terraform is modified outside of Terraform.
2. Changes made directly in the console cause discrepancies between the code and the actual state.
3. Always use Terraform to manage resources to avoid drift.

---

### Is `terraform apply` Disruptive, Destructive, or Concurrent?
- **Non-disruptive**: Changes like updating tags or roles.
- **Disruptive**: Changes like modifying `instance_type` (involves downtime).
- **Destructive**: Changes like updating the AMI (recreates the resource).

---

## Variables in Terraform

### Supported Data Types
1. **Numbers**: No quotes required.
2. **Booleans**: No quotes required.
3. **Strings**: Enclosed in double quotes (single quotes are not supported).

### Types of Variables
1. **Regular Variable**: A key with a single value.
2. **List Variable**: A key with multiple values.
3. **Map Variable**: A key with multiple key-value pairs.

#### Syntax
```hcl
var.sample    # Use this if not enclosed in a string.
${var.sample} # Use this if enclosed in a string.
```

---

## Outputs
1. Outputs are used to print information.
2. Outputs are also used to share information between Terraform modules.

---

## Naming Standards
1. Use lowercase letters with `_` or `-`.
2. Follow camelCase for variable names.

---

## `terraform.tfvars`
- Holds default values used across environments.
- Terraform automatically picks up `terraform.tfvars` without explicit mention.
- For environment-specific files (e.g., `dev.tfvars`, `qa.tfvars`), specify the file during execution.

### Example Commands
```bash
$ terraform init ; terraform plan --var-file=dev.tfvars
$ terraform init ; terraform plan --var-file=dev.tfvars -var environment=cli
```

### Variable Priority
`cliVariables > ***.tfvars > terraform.tfvars > terraform.auto.tfvars`

---

## Modules in Terraform
1. **Purpose**: Keep code DRY and reusable.
2. **Types**:
   - **Registry Modules**: Pre-built modules available in the Terraform registry.
   - **Custom Modules**: Build your own modules.

### Module Types
1. **Root Module**: The main module where Terraform commands are executed.
2. **Child Module**: Modules called by the root module.

#### Passing Information Between Modules
- Information flows through the root module using outputs.
- Example:
  ```
  x-module ---> RootModule ---> y-module
  ```

---

## Arguments vs Attributes
- **Arguments**: Properties needed to provision a resource (e.g., `instance_type`, `disk_size`).
- **Attributes**: Properties available after resource provisioning (e.g., `private_ip`, `instance_id`, `arn`).

---

## Data Sources
- Data sources help query existing information in the infrastructure.

---

## Provisioners in Terraform
1. **Local Provisioner**: Executes actions on the machine running Terraform.
2. **Remote Provisioner**: Executes actions on the provisioned resource.
3. **Connection Provisioner**: Enables connections to perform actions on the provisioned resource.

### Notes
- Provisioners are executed only during resource creation.
- To re-execute provisioners, use triggers.

---

## Terraform State
- **Definition**: A file that tracks the infrastructure managed by Terraform.
- **Purpose**: Records resource attributes, dependencies, and metadata.
- **Storage**: Can be stored locally or remotely.

### Risks of Local State Storage
1. Limited collaboration.
2. Risk of loss.
3. Security concerns.
4. Manual backups required.
5. No state locking.

### Best Practices for State Management
1. Use S3 buckets for state storage (if on AWS).
2. Enable encryption and versioning on S3.
3. Restrict write access to the bucket.

---

## Terraform Plan
1. Reads resource properties from the state file.
2. Validates the code against the state file and the actual infrastructure.
3. Treats the code as the source of truth.

---

## Lost State File
- Losing the state file causes Terraform to lose track of resources, which is a critical issue.

---

## Organizing State for Multiple Environments
- Use separate backend configuration files for each environment.
- Example:
  ```bash
  $ terraform init -backend-config=env-dev/state.tfvars -var-file=env-dev/main.tfvars
  $ terraform plan -var-file=env-dev/main.tfvars
  $ terraform apply -var-file=env-dev/main.tfvars -auto-approve
  ```

---

## Summary of `terraform init`
1. Initializes the backend.
2. Downloads required plugins.
3. Initializes modules.

---

This document provides a comprehensive overview of Terraform concepts, commands, and best practices. Follow these guidelines to effectively manage your infrastructure using Terraform.