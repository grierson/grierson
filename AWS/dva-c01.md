# DVA-C01 - AWS Developer - Associate

| Domain                         | %   |
| ------------------------------ | --- |
| Development with AWS           | 30% |
| Security                       | 26% |
| Deployment                     | 22% |
| Monitoring and Troubleshooting | 12% |
| Refactoring                    | 10% |

- Development - 30%
  - Lambda
  - API Gateway
  - DynamoDB
- Security - 26%
  - Key Management Service
  - Cognito
  - IAM
- Deployment - 22%
  - Code commit
  - Code build
  - Code deploy
  - Code pipeline
  - Elastic Beanstalk
  - Cloud Formation
- Monitoring and Troubleshooting - 12%
  - X-Ray
  - Config
  - Cloud Trail
  - Cloud Watch
- Refactoring - 10%
  - Migrate to AWS

## Development

Write Serverless application

- Compare server vs serverless
  - Microservices
  - Stateless nature of serverless
  - Scaling serverless
  - Decoupling layers of serverless
- Tools
  - AWS Lambda
  - API Gateway
  - DynamoDB
  - S3 Events
  - Kinesis

Use case -> Application design

- Real-time vs batch processing
- Sync vs Async
- Event vs Polling
- Trade-offs for consistency models

Design -> Code

- Use SQS, SNS, ElastiCache, DynamoDB, S3, Lambda

Interact with AWS services

- APIs, SDKs, CLI
- Handle exceptions

## Security

Authenticated calls to AWS

- Create roles and policies

Implement encryption

- Encrypt data at rest and transit

Implement Authentication and authorization

- Amazon Cognito identity
  - Sign up and Sign in

## Deployment

Create CI/CD

- CodeStar
- CodePipeline
  - Create workflow
- CodeCommit
- CodeBuild
- CodeDeploy

Deploy application

- Elastic Beanstalk
  - Package application
  - Versioning
- Cloudwatch
  - Instrument application

Prepare application for deployment

- Manage dependencies (environment variables, config)
- Project structure

Deploy serverless application

- Use case -> AWS Serverless Application Model (AWS SAM)
- Manage environments in individual AWS services

## Monitoring

Write code to be monitored

- Create Cloudwatch Metrics

Perform root cause analysis

- Read logs
- Check build history
- Find faulty component
- Tools
  - Cloudwatch
  - VPC flow logs
  - X-Ray

## Refactoring

Optimise application to best use AWS

- Implement AWS caching
  - ElastiCache
  - API Gateway cache
- S3 naming scheme for read performance

Migrate app to AWS

- Isolate dependencies
- Develop to enable horizontal scalability

## Tools

Analytics:

- Amazon Elasticsearch Service (Amazon ES)
- Amazon Kinesis

Application Integration:

- Amazon EventBridge (Amazon CloudWatch Events)
- Amazon Simple Notification Service (Amazon SNS)
- Amazon Simple Queue Service (Amazon SQS)
- AWS Step Functions

Compute:

- Amazon EC2
- AWS Elastic Beanstalk
- AWS Lambda

Containers:

- Amazon Elastic Container Registry (Amazon ECR)
- Amazon Elastic Container Service (Amazon ECS)
- Amazon Elastic Kubernetes Services (Amazon EKS)

Database:

- Amazon DynamoDB
- Amazon ElastiCache
- Amazon RDS

Developer Tools:

- AWS CodeArtifact
- AWS CodeBuild
- AWS CodeCommit
- AWS CodeDeploy
- Amazon CodeGuru
- AWS CodePipeline
- AWS CodeStar
- AWS Fault Injection Simulator
- AWS X-Ray

Management and Governance:

- AWS CloudFormation
- Amazon CloudWatch

Networking and Content Delivery:

- Amazon API Gateway
- Amazon CloudFront
- Elastic Load Balancing

Security, Identity, and Compliance:

- Amazon Cognito
- AWS Identity and Access Management (IAM)
- AWS Key Management Service (AWS KMS)

Storage:

- Amazon S3
