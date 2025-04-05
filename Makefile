# Variables
AWS_ACCOUNT_ID ?= $(shell aws sts get-caller-identity --query Account --output text)
AWS_REGION ?= us-east-1
ECR_REPOSITORY ?= fastapi-lambda
LAMBDA_FUNCTION ?= fastapi-lambda
IMAGE_TAG ?= latest

# Commands
.PHONY: build deploy test clean

# Build Docker image
build:
	@echo "🔨 Building Docker image $(ECR_REPOSITORY):$(IMAGE_TAG)..."
	docker build -t $(ECR_REPOSITORY) .
	@echo "✅ Docker image built successfully"

# Login to Amazon ECR
ecr-login:
	@echo "🔑 Logging in to Amazon ECR..."
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	@echo "✅ Successfully logged in to ECR"

# Tag and push image to ECR
push: build
	@echo "🏷️  Tagging Docker image for ECR..."
	docker tag $(ECR_REPOSITORY):$(IMAGE_TAG) $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG)
	@echo "⬆️  Pushing image to ECR..."
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG)
	@echo "✅ Image successfully pushed to ECR"

# Update Lambda function with new image
update-lambda: push
	@echo "🔄 Updating Lambda function $(LAMBDA_FUNCTION) with new image..."
	aws lambda update-function-code --no-cli-pager --function-name $(LAMBDA_FUNCTION) --image-uri $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG)
	@echo "✅ Lambda function updated successfully"

# Apply Terraform infrastructure
deploy-infra:
	@echo "🏗️  Deploying infrastructure with Terraform..."
	cd terraform && terraform init && terraform apply -auto-approve
	@echo "✅ Infrastructure deployed successfully"

# Test the API endpoint
test:
	@echo "🧪 Testing API endpoint..."
	@curl -s https://60ujutz4wk.execute-api.$(AWS_REGION).amazonaws.com/ | jq .
	@echo "✅ API test completed"

# Clean local resources
clean:
	@echo "🧹 Cleaning local Docker images..."
	docker rmi $(ECR_REPOSITORY):$(IMAGE_TAG) || true
	docker rmi $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPOSITORY):$(IMAGE_TAG) || true
	@echo "✅ Clean completed"

# Complete deployment pipeline
deploy: ecr-login push update-lambda
	@echo "🚀 Deployment completed successfully"

# Run everything
all: deploy test
	@echo "✨ All tasks completed successfully" 