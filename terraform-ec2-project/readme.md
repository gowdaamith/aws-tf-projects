                              INTERNET
                                  │
                                  │
                                  ▼
                         ┌─────────────────┐
                         │  Internet       │
                         │  Gateway (IGW)   │
                         └────────┬────────┘
                                  │
                                  ▼
                    ┌──────────────────────────┐
                    │       AWS VPC             │
                    │      10.0.0.0/16          │
                    │                           │
                    │  ┌────────────────────┐   │
                    │  │  Public Subnet     │   │
                    │  │  10.0.1.0/24       │   │
                    │  │  ap-south-1a        │   │
                    │  │                    │   │
                    │  │  ┌──────────────┐  │   │
                    │  │  │ EC2 Instance │  │   │
                    │  │  │ Ubuntu 24.04 │  │   │
                    │  │  │              │  │   │
                    │  │  │ Nginx        │  │   │
                    │  │  │ SSM Agent    │  │   │
                    │  │  └──────┬───────┘  │   │
                    │  │         │          │   │
                    │  └─────────┼──────────┘   │
                    │            │              │
                    └────────────┼──────────────┘
                                 │
              ┌──────────────────┼──────────────────┐
              │                  │                  │
              ▼                  ▼                  ▼
       ┌─────────────┐   ┌─────────────┐   ┌────────────────┐
       │ Root EBS    │   │ Data EBS    │   │ IAM Instance   │
       │             │   │             │   │ Profile        │
       │ 20 GiB      │   │ 10 GiB      │   │                │
       │ gp3         │   │ gp3         │   │ EC2 Role       │
       │ Encrypted   │   │ Encrypted   │   │      │         │
       │             │   │             │   │      ▼         │
       │ Ubuntu OS   │   │ /data       │   │ SSM Policy      │
       └─────────────┘   └──────┬──────┘   └────────────────┘
                                │
                                │ Backup=true
                                ▼
                       ┌──────────────────┐
                       │   AWS Backup     │
                       │                  │
                       │ Backup Selection  │
                       │       │          │
                       │       ▼          │
                       │  Backup Plan     │
                       │       │          │
                       │  Daily Backup    │
                       │       │          │
                       │  30-day Retention│
                       │       │          │
                       │       ▼          │
                       │  Backup Vault    │
                       └──────────────────┘
