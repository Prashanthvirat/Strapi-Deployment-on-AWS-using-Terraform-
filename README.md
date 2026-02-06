# Strapi-Deployment-on-AWS-using-Terraform-
Task 4 — Private EC2 Strapi Deployment using Terraform (ALB + NAT)
✅ Overview

This project provisions a secure and production-style AWS infrastructure using Terraform to deploy a Strapi application on a private EC2 instance, accessible only through an Application Load Balancer (ALB).

🏗️ Architecture
Network Design

Custom VPC

Public Subnets (2 AZs)

Used for ALB

Used for NAT Gateway

Private Subnet

Used for Strapi EC2

No public IP assigned

Traffic Flow
Internet → ALB (Public Subnets) → EC2 (Private Subnet) → Strapi App

Outbound Internet

Private EC2 gets outbound access through:

Private Subnet → NAT Gateway → Internet


This enables secure system updates and Strapi dependency downloads without exposing the EC2 publicly.

🔐 Security
EC2 Instance

Launched in Private Subnet

No public IP

Strapi port 1337 is NOT open to the internet

Security Group Rules
ALB Security Group

Inbound:

HTTP (80) → 0.0.0.0/0

Outbound:

All traffic allowed

EC2 Security Group

Inbound:

Strapi (1337) → allowed ONLY from ALB SG

SSH (22) → allowed only from my IP (/32)

Outbound:

All traffic allowed

⚙️ Automation
Terraform Infrastructure as Code

Terraform provisions the complete stack:

VPC

Public + Private Subnets

Internet Gateway

NAT Gateway

Route Tables

ALB + Listener + Target Group

Private EC2 instance

Key Pair generation

Security Groups

🚀 Strapi Auto Deployment (user_data)

The EC2 instance uses user_data to automatically:

Install required dependencies (Node, NPM, etc.)

Create Strapi project

Build Strapi in production mode

Start Strapi using PM2

Ensure the service survives reboots

Strapi runs on:

Port: 1337

Host: 0.0.0.0 (required for ALB reachability)

📦 Environment Management

This project supports clean environment separation using:

terraform.tfvars

Example:

dev.tfvars

prod.tfvars
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8b5e510d-6e2c-42df-9aa3-5991760aa85b" />
