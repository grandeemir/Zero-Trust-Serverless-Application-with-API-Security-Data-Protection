![Architechture Diagram](assets/diagram.png)

# 🔐 Zero-Trust Serverless API on AWS  
### Secure, Encrypted & Self-Healing Cloud Architecture

## 📌 Project Overview

This project demonstrates a **Zero-Trust serverless architecture** built on AWS.  
It focuses on API security, identity-based access control, encryption, logging, threat detection, and automated remediation.

The system is designed with a **defense-in-depth strategy**, assuming that breaches are inevitable and implementing controls at every layer.

---

## 🛡 Security Architecture

This project implements Zero-Trust principles:

### 1️⃣ Network Layer
- AWS WAF (L7 filtering)
- Managed rule groups (SQLi, XSS protection)
- Rate limiting
- IP reputation filtering

### 2️⃣ Identity & Access Management
- Amazon Cognito for JWT-based authentication
- API Gateway Authorizer validation
- IAM least-privilege roles
- No wildcard permissions

### 3️⃣ Compute Security
- AWS Lambda with restricted IAM role
- Secrets retrieved dynamically from AWS Secrets Manager
- No hardcoded credentials
- Encrypted environment variables

### 4️⃣ Data Protection
- DynamoDB encryption using AWS KMS
- S3 bucket with KMS encryption
- S3 Block Public Access enabled
- Tokenization logic for sensitive fields

### 5️⃣ Logging & Monitoring
- AWS CloudTrail enabled
- CloudWatch logs for Lambda & API Gateway
- AWS GuardDuty for threat detection
- AWS Config for compliance monitoring

### 6️⃣ Automated Threat Response
- GuardDuty findings sent to EventBridge
- EventBridge triggers:
  - SNS notification
  - Automated remediation Lambda

Example remediation actions:
- Reverting public S3 bucket configuration
- Disabling compromised IAM user
- Applying restrictive bucket policy

---

## 🎯 Zero-Trust Design Principles Applied

- Never trust network traffic
- Never trust identity without verification
- Enforce least privilege
- Encrypt data at rest and in transit
- Continuously monitor for anomalies
- Automatically respond to threats

---

## 📂 Repository Structure

```
zero-trust-serverless-api/
│
├── architecture/
│   ├── diagram.png
│   └── threat-model.md
│
├── lambda/
│   ├── app.py
│   └── requirements.txt
│
├── policies/
│   ├── -
│   └── kms-key-policy.json
│
├── docs/
│   ├── deployment-steps.md
│   └── security-controls.md
│
└── terraform/   (Infrastructure as Code - planned phase)
```

---

## 🚀 Deployment Steps (Console-Based Version)

1. Create Cognito User Pool
2. Configure API Gateway with Cognito Authorizer
3. Deploy Lambda function
4. Attach least-privilege IAM role
5. Enable DynamoDB & S3 encryption with KMS
6. Enable GuardDuty, CloudTrail, AWS Config
7. Create EventBridge rule for security findings
8. Configure SNS and remediation Lambda

---

## 🔎 Threat Model

| Threat | Mitigation |
|--------|------------|
| SQL Injection | AWS WAF Managed Rules |
| Cross-Site Scripting (XSS) | WAF filtering |
| Stolen JWT | Expiration + Signature validation |
| IAM privilege escalation | Least privilege + CloudTrail |
| Data exfiltration | KMS encryption |
| Public S3 exposure | AWS Config + Auto-remediation |
| Suspicious API calls | GuardDuty |

---

## 🧪 Attack Simulation (Test Scenario)

To validate detection and response mechanisms:

1. Intentionally misconfigured S3 bucket to public.
2. AWS Config detected non-compliance.
3. EventBridge triggered remediation Lambda.
4. Bucket policy automatically reverted.
5. SNS notification sent.

This demonstrates automated, self-healing security behavior.

---

## 📊 Security Controls Summary

- Defense-in-depth architecture
- Full logging & audit trail
- Encryption at rest & in transit
- Automated remediation workflow
- Zero hardcoded secrets
- Production-ready IAM policy structure

---

## 🔄 Future Improvements

- Full Terraform automation
- Security Hub integration
- VPC endpoints for private service access
- Mutual TLS for API Gateway
- CI/CD pipeline with security scanning

---

## 📚 Technologies Used

- AWS WAF
- Amazon Cognito
- API Gateway
- AWS Lambda
- DynamoDB
- Amazon S3
- AWS KMS
- AWS Secrets Manager
- AWS GuardDuty
- AWS Config
- Amazon EventBridge
- Amazon SNS

---

## 🏁 Conclusion

This project showcases a real-world secure serverless architecture using AWS services.  
It demonstrates practical implementation of Zero-Trust principles combined with automated detection and response mechanisms.

Designed and implemented as part of a cloud security engineering portfolio.

---

## 👤 Author

Emir  
Cloud Security Enthusiast | AWS Solutions Architecture & Security Focus