# FastAPI Lambda Container Boilerplate

[🇧🇷 Versão em Português](README.pt.md)

This is a boilerplate project for creating a FastAPI application that runs in an AWS Lambda container, exposed through API Gateway and with logs configured in CloudWatch.

## 🚀 Technologies

- Python 3.12
- FastAPI
- Poetry (dependency management)
- Docker
- AWS Lambda
- AWS API Gateway
- AWS CloudWatch
- Terraform (IaC)

## 📋 Prerequisites

- Python 3.12
- Docker
- AWS CLI configured
- Terraform
- Poetry

## 🛠️ Environment Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd poetry-lambda-container-boiler-plate
   ```

2. Install dependencies with Poetry:
   ```bash
   poetry install
   ```

3. Configure your AWS credentials:
   ```bash
   aws configure
   ```

4. Copy the example variables file:
   ```bash
   cp terraform/example.tfvars terraform/terraform.tfvars
   ```

5. Adjust the variables in `terraform/terraform.tfvars` as needed.

## 🏗️ Project Structure

```
.
├── app/                    # FastAPI application code
│   ├── __init__.py
│   └── main.py            # Application entry point
├── terraform/             # Infrastructure configuration
│   ├── main.tf           # Main configuration
│   ├── variables.tf      # Variables
│   └── outputs.tf        # Outputs
├── Dockerfile            # Container configuration
├── Makefile             # Automation commands
├── pyproject.toml       # Python dependencies
└── README.md            # This file
```

## 🚀 Deployment

The project uses a Makefile to automate the deployment process. Main commands:

```bash
make deploy              # Run the complete deployment pipeline
make build              # Build Docker image
make push               # Push image to ECR
make update-lambda      # Update Lambda function
make test              # Test API endpoint
make clean             # Clean local resources
```

## 🔒 Security

### AWS Credentials
1. Never commit AWS credentials directly in the code
2. Use environment variables or AWS CLI profiles
3. Configure your AWS credentials locally:
   ```bash
   aws configure
   ```

### Environment Variables
1. Create a `.env` file based on `.env.example`
2. Never commit the `.env` file to the repository
3. Use secure values for all sensitive variables

### Terraform
1. Never commit `.tfvars` files with real values
2. Use `example.tfvars` as a template
3. Keep Terraform state files (.tfstate) out of version control

## 📝 Logs and Monitoring

- Application logs: CloudWatch Logs in `/aws/lambda/fastapi-lambda`
- API Gateway logs: CloudWatch Logs in `/aws/apigateway/fastapi-lambda`
- Metrics: CloudWatch Metrics for Lambda and API Gateway

## 🔄 CI/CD

The project is configured for:
- Automatic Docker image build
- Push to ECR
- Automatic Lambda function update
- Automated endpoint testing

## 📚 API Documentation

API documentation is available at:
- Swagger UI: `https://<api-id>.execute-api.<region>.amazonaws.com/docs`
- ReDoc: `https://<api-id>.execute-api.<region>.amazonaws.com/redoc`

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details. 