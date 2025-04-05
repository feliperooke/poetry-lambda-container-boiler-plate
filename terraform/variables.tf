variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "$default"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "fastapi-lambda"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "fastapi-lambda"
} 