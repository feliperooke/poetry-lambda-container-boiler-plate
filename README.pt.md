# FastAPI Lambda Container Boilerplate

[🇺🇸 English Version](README.md)

Este é um projeto boilerplate para criar uma aplicação FastAPI que roda em um container AWS Lambda, exposta através do API Gateway e com logs configurados no CloudWatch.

## 🚀 Tecnologias

- Python 3.12
- FastAPI
- Poetry (gerenciamento de dependências)
- Docker
- AWS Lambda
- AWS API Gateway
- AWS CloudWatch
- Terraform (IaC)

## 📋 Pré-requisitos

- Python 3.12
- Docker
- AWS CLI configurado
- Terraform
- Poetry

## 🛠️ Configuração do Ambiente

1. Clone o repositório:
   ```bash
   git clone <repository-url>
   cd poetry-lambda-container-boiler-plate
   ```

2. Instale as dependências com Poetry:
   ```bash
   poetry install
   ```

3. Configure suas credenciais AWS:
   ```bash
   aws configure
   ```

4. Copie o arquivo de variáveis de exemplo:
   ```bash
   cp terraform/example.tfvars terraform/terraform.tfvars
   ```

5. Ajuste as variáveis em `terraform/terraform.tfvars` conforme necessário.

## 🏗️ Estrutura do Projeto

```
.
├── app/                    # Código da aplicação FastAPI
│   ├── __init__.py
│   └── main.py            # Ponto de entrada da aplicação
├── terraform/             # Configuração de infraestrutura
│   ├── main.tf           # Configuração principal
│   ├── variables.tf      # Variáveis
│   └── outputs.tf        # Outputs
├── Dockerfile            # Configuração do container
├── Makefile             # Comandos de automação
├── pyproject.toml       # Dependências Python
└── README.md            # Este arquivo
```

## 🚀 Deployment

O projeto usa um Makefile para automatizar o processo de deployment. Os principais comandos são:

```bash
make deploy              # Executa o pipeline completo de deployment
make build              # Constrói a imagem Docker
make push               # Faz push da imagem para o ECR
make update-lambda      # Atualiza a função Lambda
make test              # Testa o endpoint da API
make clean             # Limpa recursos locais
```

## 🔒 Segurança

### Credenciais AWS
1. Nunca comite credenciais AWS diretamente no código
2. Use variáveis de ambiente ou AWS CLI profiles
3. Configure suas credenciais AWS localmente:
   ```bash
   aws configure
   ```

### Variáveis de Ambiente
1. Crie um arquivo `.env` baseado no `.env.example`
2. Nunca comite o arquivo `.env` no repositório
3. Use valores seguros para todas as variáveis sensíveis

### Terraform
1. Nunca comite arquivos `.tfvars` com valores reais
2. Use o arquivo `example.tfvars` como template
3. Mantenha os arquivos de estado do Terraform (.tfstate) fora do controle de versão

## 📝 Logs e Monitoramento

- Logs da aplicação: CloudWatch Logs em `/aws/lambda/fastapi-lambda`
- Logs do API Gateway: CloudWatch Logs em `/aws/apigateway/fastapi-lambda`
- Métricas: CloudWatch Metrics para Lambda e API Gateway

## 🔄 CI/CD

O projeto está configurado para:
- Build automático da imagem Docker
- Push para ECR
- Atualização automática da função Lambda
- Testes automatizados do endpoint

## 📚 Documentação da API

A documentação da API está disponível em:
- Swagger UI: `https://<api-id>.execute-api.<region>.amazonaws.com/docs`
- ReDoc: `https://<api-id>.execute-api.<region>.amazonaws.com/redoc`

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes. 