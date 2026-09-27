# Terraform AWS Auto Scaling Group Project

A production-style AWS infrastructure project built using **Terraform**.

This project provisions a highly available web application infrastructure using an **Application Load Balancer (ALB)**, **Auto Scaling Group (ASG)**, private EC2 instances, NAT Gateways, Network ACLs, Security Groups, IAM, CloudWatch, and VPC Flow Logs.

The infrastructure is designed using a **modular Terraform architecture** so that individual components can be reused and maintained independently.

---

## Architecture

```text
                                  INTERNET
                                      |
                                      v
                           +----------------------+
                           |   Internet Gateway   |
                           +----------+-----------+
                                      |
                         +------------+------------+
                         |                         |
                         v                         v
                  Public Subnet AZ-1       Public Subnet AZ-2
                         |                         |
                         +------------+------------+
                                      |
                                      v
                           +----------------------+
                           | Application Load     |
                           | Balancer (ALB)       |
                           +----------+-----------+
                                      |
                                Target Group
                                      |
                         +------------+------------+
                         |                         |
                         v                         v
                  Private Subnet AZ-1       Private Subnet AZ-2
                         |                         |
                    +----+----+               +----+----+
                    |  EC2    |               |  EC2    |
                    | Instance|               | Instance|
                    +----+----+               +----+----+
                         |                         |
                         +------------+------------+
                                      |
                                      v
                                NAT Gateway
                                      |
                                      v
                              Internet Gateway
                                      |
                                      v
                                  INTERNET


             +---------------------------------------+
             |              Supporting Services       |
             |                                       |
             | IAM                                   |
             | Security Groups                       |
             | Network ACLs                          |
             | CloudWatch                            |
             | VPC Flow Logs                         |
             | S3 Logging Bucket                     |
             +---------------------------------------+
```

---

# Project Objectives

The main objectives of this project are:

* Build AWS infrastructure using Terraform.
* Follow a modular Terraform architecture.
* Create a custom VPC from scratch.
* Deploy resources across multiple Availability Zones.
* Deploy application servers in private subnets.
* Use an Application Load Balancer for incoming traffic.
* Use an Auto Scaling Group to automatically manage EC2 instances.
* Use Launch Templates for EC2 configuration.
* Implement Security Groups and Network ACLs.
* Use IAM roles instead of hardcoded AWS credentials.
* Configure CloudWatch monitoring and auto scaling.
* Enable VPC Flow Logs.
* Store flow logs securely in Amazon S3.
* Practice Terraform variables, locals, outputs, modules, `for_each`, and `map(object(...))`.
* Use `terraform plan` to verify infrastructure before deployment.

---

# Technology Stack

| Technology           | Purpose                         |
| -------------------- | ------------------------------- |
| Terraform            | Infrastructure as Code          |
| AWS VPC              | Network isolation               |
| AWS EC2              | Application servers             |
| AWS Auto Scaling     | Automatic EC2 scaling           |
| AWS ALB              | Load balancing                  |
| AWS Target Group     | EC2 target management           |
| AWS IAM              | Access control                  |
| AWS Security Groups  | Stateful network security       |
| AWS Network ACL      | Stateless subnet-level security |
| AWS NAT Gateway      | Private subnet internet access  |
| AWS Internet Gateway | Internet connectivity           |
| AWS CloudWatch       | Monitoring and scaling          |
| Amazon S3            | VPC Flow Log storage            |
| Ubuntu               | EC2 operating system            |

---

# AWS Region

The project is configured for:

```text
ap-south-1
```

The region can be changed through Terraform variables.

---

# Network Architecture

The project uses a VPC with CIDR:

```text
10.0.0.0/16
```

The VPC is divided into multiple subnet types.

```text
VPC
10.0.0.0/16
│
├── Public Subnets
│   ├── 10.0.1.0/24
│   ├── 10.0.2.0/24
│   └── 10.0.3.0/24
│
├── Private Application Subnets
│   ├── 10.0.11.0/24
│   ├── 10.0.12.0/24
│   └── 10.0.13.0/24
│
└── Database Subnets
    ├── 10.0.21.0/24
    ├── 10.0.22.0/24
    └── 10.0.23.0/24
```

---

# Availability Zones

The project uses three Availability Zones:

```text
ap-south-1a
ap-south-1b
ap-south-1c
```

Each Availability Zone contains:

```text
Public Subnet
Private Application Subnet
Database Subnet
```

This provides a foundation for highly available infrastructure.

---

# Traffic Flow

## Incoming Application Traffic

Users access the application through the ALB.

```text
User
 |
 | HTTP/HTTPS
 v
Internet Gateway
 |
 v
Public Subnet
 |
 v
Application Load Balancer
 |
 v
Target Group
 |
 v
Private EC2 Instance
```

The EC2 instances do not need public IP addresses.

---

## Outbound Traffic From EC2

Private EC2 instances may need internet access for package installation, updates, or external services.

The traffic flows through a NAT Gateway.

```text
Private EC2
     |
     v
Private Route Table
     |
     v
NAT Gateway
     |
     v
Internet Gateway
     |
     v
Internet
```

The NAT Gateway provides outbound internet connectivity without making the EC2 instances publicly accessible.

---

# Auto Scaling Architecture

The Auto Scaling Group manages the application EC2 instances.

Example configuration:

```text
Minimum Capacity    = 2
Desired Capacity    = 2
Maximum Capacity    = 6
```

Normal operation:

```text
             Auto Scaling Group
                    |
             +------+------+
             |             |
           EC2-1         EC2-2
```

When application load increases:

```text
             Auto Scaling Group
                    |
        +-----------+-----------+
        |           |           |
      EC2-1       EC2-2       EC2-3
```

The ASG can automatically launch additional instances according to the configured scaling policy.

---

# Launch Template

The Launch Template defines how new EC2 instances should be created.

The Launch Template contains configuration such as:

```text
AMI
Instance Type
Security Groups
IAM Instance Profile
EBS Volume
IMDSv2
User Data
Tags
```

Every new EC2 instance launched by the ASG uses this configuration.

Architecture:

```text
                 Launch Template
                       |
                       v
              Auto Scaling Group
                       |
            +----------+----------+
            |          |          |
            v          v          v
          EC2-1      EC2-2      EC2-3
```

---

# Application Load Balancer

The ALB distributes incoming traffic across healthy EC2 instances.

```text
                     ALB
                      |
                Target Group
                 /         \
                /           \
               v             v
             EC2-1         EC2-2
```

The target group performs health checks.

Example:

```text
Health Check Path: /health
Protocol: HTTP
Port: Application Port
```

If an instance becomes unhealthy, the ALB stops sending traffic to that instance.

---

# Security

Security is implemented at multiple layers.

## Security Groups

The architecture uses separate Security Groups for:

```text
ALB
Application EC2
```

Traffic flow:

```text
Internet
   |
   v
ALB Security Group
   |
   v
Application Security Group
   |
   v
EC2
```

The application Security Group allows application traffic from the ALB Security Group rather than allowing unrestricted internet access.

---

# Network ACLs

Network ACLs provide subnet-level stateless filtering.

The project includes NACLs for public and private subnets.

```text
Internet
   |
   v
Public NACL
   |
   v
Public Subnet
```

and:

```text
Private Subnet
      |
      v
Private NACL
```

Because NACLs are stateless, both inbound and outbound traffic must be considered when defining rules.

---

# IAM

EC2 instances use an IAM Role through an Instance Profile.

```text
IAM Role
   |
   v
Instance Profile
   |
   v
Launch Template
   |
   v
EC2
```

AWS credentials are not hardcoded into the EC2 instances.

---

# CloudWatch

CloudWatch is used to monitor the infrastructure and support Auto Scaling.

The project can monitor:

* EC2 CPU utilization
* Auto Scaling Group metrics
* Scaling activities
* Instance health

Example scaling concept:

```text
CPU Utilization
       |
       v
   CloudWatch
       |
       v
Scaling Policy
       |
       v
Auto Scaling Group
```

Example target:

```text
Target CPU Utilization = 70%
```

---

# VPC Flow Logs

VPC Flow Logs provide visibility into network traffic.

```text
VPC
 |
 v
VPC Flow Logs
 |
 v
S3 Bucket
```

The S3 bucket is configured with security best practices such as:

* Public access blocked
* Versioning enabled
* Server-side encryption
* Appropriate bucket policy

---

# Terraform Project Structure

```text
terraform-asg-project/
│
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── modules/
│   │
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── internet-gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── nat-gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── locals.tf
│   │   └── outputs.tf
│   │
│   ├── route-table/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── nacl/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── launch-template/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── auto-scaling-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── cloudwatch/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── logging-bucket/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md
```

---

# Terraform Module Responsibilities

| Module               | Responsibility                                       |
| -------------------- | ---------------------------------------------------- |
| `vpc`                | Creates VPC                                          |
| `subnet`             | Creates public/private/database subnets              |
| `internet-gateway`   | Provides internet connectivity                       |
| `nat-gateway`        | Provides outbound internet access to private subnets |
| `route-table`        | Controls subnet routing                              |
| `security-group`     | Controls stateful instance/network traffic           |
| `nacl`               | Controls stateless subnet traffic                    |
| `iam`                | Creates EC2 IAM role and instance profile            |
| `launch-template`    | Defines EC2 configuration                            |
| `alb`                | Creates ALB, listener and target group               |
| `auto-scaling-group` | Manages EC2 capacity                                 |
| `cloudwatch`         | Monitoring and scaling policies                      |
| `logging-bucket`     | Stores VPC Flow Logs                                 |

---

# Terraform Configuration Style

The project uses reusable Terraform modules instead of placing all resources in a single file.

It also uses structured variables such as:

```hcl
variable "instances" {
  type = map(object({
    instance_type = string
    subnet_type   = string
    az            = string
  }))
}
```

This allows infrastructure to be represented as structured data.

Example:

```hcl
instances = {
  app_1 = {
    instance_type = "t3.micro"
    subnet_type   = "private"
    az            = "ap-south-1a"
  }

  app_2 = {
    instance_type = "t3.micro"
    subnet_type   = "private"
    az            = "ap-south-1b"
  }
}
```

The project also makes extensive use of:

```text
for_each
for expressions
map(object(...))
locals
variables
outputs
module dependencies
```

---

# Prerequisites

Install the following:

* Terraform
* AWS CLI
* Git
* An AWS account

Verify Terraform:

```bash
terraform version
```

Verify AWS CLI:

```bash
aws --version
```

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

---

# Terraform Initialization

Move into the environment directory:

```bash
cd environments/dev
```

Initialize Terraform:

```bash
terraform init
```

This downloads the required providers and initializes the Terraform working directory.

---

# Terraform Formatting

Format the Terraform configuration:

```bash
terraform fmt -recursive
```

This formats all Terraform files recursively.

---

# Terraform Validation

Validate the configuration:

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

# Terraform Plan

Before creating infrastructure, generate an execution plan:

```bash
terraform plan
```

This allows you to review the resources Terraform intends to create.

The recommended workflow is:

```text
Write Terraform
      |
      v
terraform fmt
      |
      v
terraform validate
      |
      v
terraform plan
      |
      v
Review
      |
      v
terraform apply
```

---

# Deployment

When you are ready to create the infrastructure:

```bash
terraform apply
```

Review the proposed changes and confirm when prompted.

After deployment, Terraform outputs can be displayed using:

```bash
terraform output
```

---

# Destroying Infrastructure

When the infrastructure is no longer required:

```bash
terraform destroy
```

This removes resources managed by Terraform.

> Always review the destroy plan carefully before confirming.

---

# Cost Considerations

Some AWS resources in this project can incur charges even when they are not handling application traffic.

Potential cost-generating resources include:

* NAT Gateways
* Application Load Balancer
* EC2 instances
* Elastic IP addresses
* CloudWatch resources
* S3 storage and requests

For learning purposes, infrastructure should be destroyed when it is no longer required:

```bash
terraform destroy
```

For development, use appropriately sized resources such as:

```text
t3.micro
```

where supported by the requirements.

---

# High Availability Design

The architecture is designed around multiple Availability Zones.

```text
                ALB
             /       \
            /         \
          AZ-1       AZ-2
           |           |
        EC2-1       EC2-2
```

If an individual EC2 instance becomes unhealthy, the ASG can replace it.

If an application instance fails:

```text
Unhealthy EC2
      |
      v
Target Group detects failure
      |
      v
ALB stops sending traffic
      |
      v
ASG replaces instance
      |
      v
New EC2 becomes healthy
```

---

# Infrastructure Lifecycle

The complete infrastructure lifecycle is:

```text
                    Terraform
                       |
                       v
                 AWS Provider
                       |
                       v
                      VPC
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
     Subnets        Routing          NACL
        |              |              |
        +--------------+--------------+
                       |
                       v
                Security Groups
                       |
                       v
                      IAM
                       |
                       v
               Launch Template
                       |
                       v
                Application ALB
                       |
                       v
                 Target Group
                       |
                       v
              Auto Scaling Group
                       |
              +--------+--------+
              |        |        |
              v        v        v
             EC2      EC2      EC2
              |
              v
          CloudWatch
              |
              v
        Scaling Policies
```

---

# Validation Checklist

Before considering the project complete, verify:

## Terraform

* [ ] Terraform initializes successfully
* [ ] Terraform formatting is correct
* [ ] `terraform validate` succeeds
* [ ] `terraform plan` succeeds
* [ ] Variables are properly defined
* [ ] Outputs are available
* [ ] Modules are reusable

## Networking

* [ ] VPC created
* [ ] Public subnets created
* [ ] Private application subnets created
* [ ] Database subnets created
* [ ] Internet Gateway configured
* [ ] NAT Gateways configured
* [ ] Route tables configured
* [ ] Network ACLs configured

## Security

* [ ] ALB Security Group configured
* [ ] Application Security Group configured
* [ ] EC2 instances do not require public IP addresses
* [ ] IAM Role configured
* [ ] IAM Instance Profile attached
* [ ] IMDSv2 enabled/required

## Load Balancing

* [ ] ALB created
* [ ] Target Group created
* [ ] Listener configured
* [ ] Health checks configured
* [ ] EC2 instances registered with target group

## Auto Scaling

* [ ] Launch Template created
* [ ] ASG created
* [ ] Minimum capacity configured
* [ ] Desired capacity configured
* [ ] Maximum capacity configured
* [ ] Scaling policy configured
* [ ] Health checks configured

## Monitoring

* [ ] CloudWatch metrics configured
* [ ] Scaling alarms/policies configured
* [ ] VPC Flow Logs enabled
* [ ] S3 logging bucket configured

---

# Learning Outcomes

After completing this project, the following Terraform and AWS concepts should be understood:

### Terraform

* Terraform providers
* Variables
* Outputs
* Locals
* Modules
* `for_each`
* `for` expressions
* `map(object(...))`
* Resource dependencies
* Module dependencies
* Terraform state
* Terraform plan
* Terraform validation
* Infrastructure lifecycle

### AWS

* VPC
* Subnets
* Availability Zones
* Internet Gateway
* NAT Gateway
* Route Tables
* Network ACLs
* Security Groups
* IAM Roles
* IAM Instance Profiles
* Launch Templates
* EC2
* Application Load Balancer
* Target Groups
* Auto Scaling Groups
* CloudWatch
* VPC Flow Logs
* S3

---

# Future Improvements

The project can later be extended with:

```text
Terraform Remote Backend
        |
        v
S3 + DynamoDB / locking mechanism
```

Other possible improvements:

* HTTPS with ACM
* Route 53
* WAF
* CloudWatch Logs
* SNS notifications
* Secrets Manager
* Systems Manager Session Manager
* AWS Backup
* RDS
* Redis/ElastiCache
* CI/CD with GitHub Actions
* Terraform security scanning
* Terraform documentation generation
* Checkov
* tfsec
* Terratest
* Separate `dev`, `staging`, and `prod` environments

---

# Project Flow

The complete project can be understood as:

```text
                    START
                      |
                      v
              Terraform Foundation
                      |
                      v
                    VPC
                      |
                      v
                   Subnets
                      |
                      v
              Internet Gateway
                      |
                      v
                NAT Gateways
                      |
                      v
                Route Tables
                      |
                      v
                 Network ACL
                      |
                      v
              Security Groups
                      |
                      v
                    IAM
                      |
                      v
              Launch Template
                      |
                      v
             Application Load Balancer
                      |
                      v
                 Target Group
                      |
                      v
             Auto Scaling Group
                      |
                      v
                  EC2 Instances
                      |
                      v
                  CloudWatch
                      |
                      v
                VPC Flow Logs
                      |
                      v
                Terraform Plan
                      |
                      v
                     END
```

---

# Final Architecture

```text
                         ┌───────────────────┐
                         │     INTERNET      │
                         └─────────┬─────────┘
                                   │
                                   v
                         ┌───────────────────┐
                         │ Internet Gateway  │
                         └─────────┬─────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    │                             │
                    v                             v
             ┌─────────────┐               ┌─────────────┐
             │ Public AZ-1 │               │ Public AZ-2 │
             └──────┬──────┘               └──────┬──────┘
                    │                             │
                    └──────────────┬──────────────┘
                                   │
                                   v
                         ┌───────────────────┐
                         │       ALB         │
                         └─────────┬─────────┘
                                   │
                                   v
                         ┌───────────────────┐
                         │    Target Group   │
                         └─────────┬─────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    │                             │
                    v                             v
             ┌─────────────┐               ┌─────────────┐
             │ Private AZ-1│               │ Private AZ-2│
             │             │               │             │
             │   EC2       │               │   EC2       │
             └──────┬──────┘               └──────┬──────┘
                    │                             │
                    └──────────────┬──────────────┘
                                   │
                                   v
                            ┌─────────────┐
                            │ NAT Gateway │
                            └──────┬──────┘
                                   │
                                   v
                            ┌─────────────┐
                            │   Internet  │
                            └─────────────┘


       ┌──────────────────────────────────────────────┐
       │              MANAGEMENT LAYER                │
       │                                              │
       │ IAM ── Launch Template ── ASG                │
       │                                              │
       │ CloudWatch ── Scaling Policies               │
       │                                              │
       │ VPC Flow Logs ── S3                         │
       │                                              │
       │ Security Groups + Network ACLs               │
       └──────────────────────────────────────────────┘
```

---

## Project Status

```text
[ ] Terraform foundation
[ ] VPC
[ ] Subnets
[ ] Internet Gateway
[ ] NAT Gateway
[ ] Route Tables
[ ] Network ACL
[ ] Security Groups
[ ] IAM
[ ] Launch Template
[ ] ALB
[ ] Target Group
[ ] Auto Scaling Group
[ ] CloudWatch
[ ] VPC Flow Logs
[ ] Terraform validation
[ ] Terraform plan
[ ] Deployment testing
```

---

## Author

**Amith K N**

Terraform / AWS Infrastructure Learning Project

