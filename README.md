Zero-Trust Serverless API on AWS

This project demonstrates a Zero-Trust serverless architecture built on AWS with strong API security, encrypted data storage, centralized logging, and automated threat detection & remediation.

The goal of this project was not just to deploy AWS services, but to design a production-style architecture that follows security best practices such as least privilege access, defense-in-depth, and encryption by default.

Architecture Overview

High-level flow:

User → AWS WAF → API Gateway → Lambda → DynamoDB / S3
Security & Monitoring → CloudTrail / GuardDuty / AWS Config → EventBridge → SNS / Remediation Lambda

Key principles implemented:

Zero-Trust access model

Defense-in-depth

Least privilege IAM

Encryption at rest and in transit

Continuous monitoring and automated response

Services Used
Identity & Access

Amazon Cognito (JWT-based authentication)

IAM Roles with least privilege policies

Secrets Manager for secure secret retrieval

API Protection

AWS WAF (managed rules, rate limiting)

API Gateway with Cognito Authorizer

HTTPS-only communication

Compute

AWS Lambda (business logic + tokenization logic)

Data Protection

DynamoDB (KMS encrypted)

S3 (KMS encrypted + Block Public Access)

AWS KMS (customer-managed keys)

Monitoring & Detection

AWS CloudTrail (API activity logging)

Amazon GuardDuty (threat detection)

AWS Config (compliance monitoring)

Amazon EventBridge (event routing)

Automated Response

SNS notifications

Remediation Lambda for automated corrective actions

Security Design Decisions
1. Zero-Trust Model

Every request is verified at multiple layers:

WAF filters malicious traffic

API Gateway validates JWT tokens

IAM enforces strict access control

Lambda operates with minimal permissions

Data is encrypted by default

No implicit trust between components.

2. Least Privilege IAM

Each component only has the permissions it strictly needs.

Examples:

Lambda can access only a specific DynamoDB table

Lambda can retrieve only required secrets

KMS key policies restrict usage to defined roles

3. Encryption Strategy

All API traffic over HTTPS

DynamoDB encrypted using AWS KMS

S3 encrypted using AWS KMS

Secrets stored in Secrets Manager

Environment variables encrypted

4. Threat Detection & Automated Remediation

The system continuously monitors for misconfiguration and suspicious behavior.

Examples:

Public S3 bucket detection

Suspicious IAM activity

Unauthorized API calls

When a security event is detected:

GuardDuty or Config generates an event

EventBridge captures the event

SNS notifies stakeholders

A remediation Lambda can automatically correct the issue

This enables a self-healing security mechanism.

Example Threat Mitigation Mapping
Threat	Mitigation
SQL Injection	AWS WAF Managed Rules
Stolen credentials	Cognito JWT validation
Over-privileged access	Least privilege IAM roles
Data exfiltration	KMS encryption
Misconfigured S3 bucket	AWS Config + automated remediation
Suspicious API activity	CloudTrail + GuardDuty
Deployment Notes

This project was initially deployed manually via AWS Console to deeply understand service interactions and IAM behavior.

Key steps:

Create Cognito User Pool and App Client

Configure API Gateway with Cognito Authorizer

Attach WAF to API Gateway

Deploy Lambda with least privilege IAM role

Enable KMS encryption for DynamoDB and S3

Enable CloudTrail, GuardDuty, and AWS Config

Configure EventBridge rules and remediation Lambda

Infrastructure as Code (Terraform version) will be added in a future iteration.

Lessons Learned

IAM policy design is the most critical and error-prone part.

Monitoring without automated response is incomplete.

Encryption is easy to enable, but proper key policy design requires attention.

Testing security controls is as important as deploying them.

Future Improvements

Terraform-based deployment

Security Hub integration

Centralized log archive bucket

CI/CD pipeline with security scanning

VPC-based private Lambda deployment with VPC endpoints