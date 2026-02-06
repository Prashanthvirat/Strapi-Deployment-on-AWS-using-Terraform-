provider "aws" {
  region = var.aws_region
}

# WARNING: Embedded credentials removed. Do NOT store AWS credentials in
# source files. Use one of the following instead:
# - Export environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN)
# - Configure a named AWS CLI profile (`aws configure --profile my-profile`) and set `profile` in the provider
# - Use instance/profile-based IAM roles when running on EC2