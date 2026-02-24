# 🚀 Deployment Steps – Console-Based Implementation

This document describes how the Zero-Trust Serverless API was deployed using AWS Console.

---

## 🧱 Phase 1 – Security Baseline

1. Enable AWS CloudTrail (Management + Data events)
2. Enable AWS GuardDuty
3. Enable AWS Config
4. Configure S3 public access compliance rules

---

## 🔐 Phase 2 – Identity Setup

1. Create Amazon Cognito User Pool
2. Configure App Client
3. Create test user
4. Configure JWT settings

---

## ⚙ Phase 3 – Compute Layer

1. Create Lambda function
2. Attach least-privilege IAM role
3. Set environment variables
4. Enable CloudWatch logging

---

## 🌐 Phase 4 – API Layer

1. Create API Gateway (HTTP API)
2. Integrate Lambda
3. Configure JWT Authorizer (Cognito)
4. Deploy stage

---

## 🛡 Phase 5 – Network Protection

1. Create AWS WAF Web ACL
2. Add Managed Rule Groups
3. Enable rate limiting
4. Associate WAF with API Gateway

---

## 💾 Phase 6 – Data Layer

1. Create DynamoDB table (KMS encrypted)
2. Create S3 bucket (Block Public Access enabled)
3. Enable default encryption (KMS)

---

## 🔑 Phase 7 – Secrets Management

1. Store secret in AWS Secrets Manager
2. Attach IAM permission to Lambda role

---

## 🔎 Phase 8 – Detection & Response

1. Create EventBridge rule for GuardDuty findings
2. Create SNS topic
3. Configure remediation Lambda
4. Test security event simulation

---

## 🧪 Validation

- Tested API authentication flow
- Verified WAF blocks malicious payloads
- Confirmed encryption at rest
- Simulated misconfiguration event
- Verified automated remediation

---

## 📌 Deployment Model

Manual console deployment (Phase 1).  
Terraform automation planned for next phase.