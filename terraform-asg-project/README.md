                         Internet
                            │
                            ▼
                    ┌───────────────┐
                    │ Internet GW   │
                    └───────┬───────┘
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
          Public Subnet A       Public Subnet B
          ap-south-1a           ap-south-1b
                 │                     │
                 └──────────┬──────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │     ALB       │
                    └───────┬───────┘
                            │
                     Target Group
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
          Private Subnet A      Private Subnet B
          ap-south-1a           ap-south-1b
                 │                     │
                 └──────────┬──────────┘
                            │
                     Auto Scaling Group
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
              EC2-A                 EC2-B
                 │                     │
                 └──────────┬──────────┘
                            │
                       CloudWatch
                            │
                            ▼
                    Scaling Policies


MODULES: 

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
│   ├── vpc/
│   ├── nacl/
│   ├── security-group/
│   ├── iam/
│   ├── launch-template/
│   ├── target-group/
│   ├── alb/
│   ├── auto-scaling-group/
│   └── cloudwatch/
│
├── scripts/
│   └── user-data.sh
│
├── versions.tf
└── readme.md



Technologies: 

Terraform
AWS VPC
Internet Gateway
NAT Gateway
Route Tables
Network ACLs
Security Groups
IAM
Ubuntu EC2
Launch Template
Application Load Balancer
Target Group
Auto Scaling Group
CloudWatch
CloudWatch scaling policies





