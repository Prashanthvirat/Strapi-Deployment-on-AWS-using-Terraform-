variable "aws_region" {
	type        = string
	default     = "us-east-1"
	description = "AWS region to create resources in"
}

variable "vpc_cidr" {
	type        = string
	default     = "10.0.0.0/16"
	description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
	type        = string
	default     = "10.0.1.0/24"
	description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
	type        = string
	default     = "10.0.2.0/24"
	description = "CIDR block for the private subnet"
}

variable "instance_type" {
	type        = string
	default     = "t3.micro"
	description = "EC2 instance type"
}

variable "key_name" {
	type        = string
	default     = "dev-key"
	description = "Name of an existing EC2 key pair. MUST be created in AWS beforehand or terraform apply will fail"
}

variable "environment" {
	type        = string
	default     = "dev"
	description = "Deployment environment (eg. dev, prod)"
}
