# Variables
AWS_ACCOUNT_ID ?= $(shell aws sts get-caller-identity --query Account --output text)
AWS_REGION ?= us-east-1
ECR_REPOSITORY ?= fastapi-lambda
LAMBDA_FUNCTION ?= fastapi-lambda
IMAGE_TAG ?= latest

# Colors for output
GREEN := \033[0;32m
NC := \033[0m # No Color

# Commands
.PHONY: ecr-login build push deploy test clean terraform-init terraform-plan terraform-apply terraform-destroy

# Login to ECR
ecr-login:
	@echo "🔑 Logging in to Amazon ECR..."
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	@echo "$(GREEN)✅ Successfully logged in to ECR$(NC)"

# Build Docker image
build: ecr-login
	@echo "🔨 Building Docker image $(ECR_REPOSITORY):$(IMAGE_TAG)..."
	docker build -t $(ECR_REPOSITORY):$(IMAGE_TAG) .
	@echo "$(GREEN)✅ Docker image built successfully$(NC)"

# Push image to ECR
push: build
	@echo "🏷️  Tagging Docker image for ECR..."
	docker tag $(ECR_REPOSITORY):$(IMAGE_TAG) $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG)
	@echo "⬆️  Pushing image to ECR..."
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG)
	@echo "$(GREEN)✅ Image successfully pushed to ECR$(NC)"

# Initialize Terraform
terraform-init:
	@echo "🚀 Initializing Terraform..."
	cd terraform && terraform init
	@echo "$(GREEN)✅ Terraform initialized successfully$(NC)"

# Plan Terraform changes
terraform-plan:
	@echo "📋 Planning Terraform changes..."
	cd terraform && terraform plan
	@echo "$(GREEN)✅ Terraform plan completed$(NC)"

# Apply Terraform changes
terraform-apply:
	@echo "🏗️  Applying Terraform changes..."
	cd terraform && terraform apply -auto-approve
	@echo "$(GREEN)✅ Terraform changes applied successfully$(NC)"

# Destroy Terraform infrastructure
terraform-destroy:
	@echo "🗑️  Destroying Terraform infrastructure..."
	cd terraform && terraform destroy -auto-approve
	@echo "$(GREEN)✅ Terraform infrastructure destroyed successfully$(NC)"

# Deploy the application
deploy: push terraform-apply
	@echo "🚀 Deployment completed successfully"

# Test the API endpoint
test:
	@echo "🧪 Testing API endpoint..."
	@curl -s https://$(shell cd terraform && terraform output -raw api_endpoint) | jq .
	@echo "$(GREEN)✅ API test completed$(NC)"

# Clean up local resources
clean:
	@echo "🧹 Cleaning up local resources..."
	docker rmi $(ECR_REPOSITORY):$(IMAGE_TAG) || true
	@echo "$(GREEN)✅ Cleanup completed$(NC)"

# Complete deployment pipeline
all: terraform-init deploy test
	@echo "$(GREEN)✨ All tasks completed successfully$(NC)" 