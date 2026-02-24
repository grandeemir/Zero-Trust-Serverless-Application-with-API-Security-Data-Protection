# 🛡 Threat Model – Zero-Trust Serverless API

## 📌 Overview

This document outlines the threat model for the Zero-Trust Serverless API architecture.  
The system assumes that breaches are inevitable and applies defense-in-depth controls at every layer.

---

## 🧠 Threat Modeling Methodology

Approach used:
- Identify entry points
- Identify sensitive assets
- Identify possible attack vectors
- Map mitigations to each threat

---

## 🎯 Protected Assets

- User identity (JWT tokens)
- Sensitive user data
- DynamoDB stored records
- S3 stored objects
- Secrets in Secrets Manager
- KMS encryption keys
- IAM roles

---

## 🚨 Identified Threats & Mitigations

| Threat | Attack Vector | Impact | Mitigation |
|--------|--------------|--------|------------|
| SQL Injection | Malicious API input | Data corruption | AWS WAF Managed Rules |
| Cross-Site Scripting (XSS) | Script injection via request | Client compromise | WAF filtering |
| Stolen JWT | Token theft | Unauthorized access | Token expiration + signature validation |
| Privilege Escalation | Overly permissive IAM | Full account compromise | Least-privilege IAM policies |
| Data Exfiltration | Stolen credentials | Sensitive data leak | KMS encryption + CloudTrail logging |
| Public S3 Exposure | Misconfiguration | Data leakage | S3 Block Public Access + AWS Config rule |
| Compromised Lambda | Runtime exploit | Data breach | Minimal permissions + no hardcoded secrets |
| Secret Exposure | Source code leak | Credential compromise | AWS Secrets Manager |
| Brute Force Attacks | Repeated login attempts | Account takeover | Cognito rate limits + WAF rate limiting |
| Insider Threat | IAM misuse | Data tampering | CloudTrail + GuardDuty monitoring |

---

## 🔐 Zero-Trust Enforcement Points

- Every request validated at API Gateway
- Identity verified via Cognito JWT
- Least privilege IAM roles
- Encryption enforced at storage level
- Continuous logging and anomaly detection
- Automated remediation via EventBridge

---

## 🧪 Attack Simulation Performed

1. S3 bucket intentionally made public.
2. AWS Config detected violation.
3. EventBridge triggered remediation Lambda.
4. Bucket policy automatically reverted.
5. SNS notification sent.

This validates automated detection and response capability.

---

## 📊 Risk Level Summary

- Network Risk → Low (WAF enforced)
- Identity Risk → Low (JWT validation)
- Data Risk → Low (Encryption at rest + in transit)
- Misconfiguration Risk → Medium (Mitigated via Config + remediation)
- Insider Risk → Medium (Mitigated via logging & monitoring)

---

## 🏁 Conclusion

The system implements layered security controls aligned with Zero-Trust principles and demonstrates practical mitigation of common cloud-native attack vectors.