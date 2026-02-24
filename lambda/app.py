import json
import os
import boto3
import hashlib
import logging
from datetime import datetime

# Structured logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# AWS clients
dynamodb = boto3.resource("dynamodb")
secrets_client = boto3.client("secretsmanager")

# Environment variables
TABLE_NAME = os.environ.get("TABLE_NAME")
SECRET_NAME = os.environ.get("SECRET_NAME")

table = dynamodb.Table(TABLE_NAME)


def get_secret(secret_name):
    try:
        response = secrets_client.get_secret_value(SecretId=secret_name)
        return response["SecretString"]
    except Exception as e:
        logger.error(f"Failed to retrieve secret: {str(e)}")
        raise


def tokenize_sensitive_data(data: str) -> str:
    """
    Tokenization using SHA-256 hashing.
    """
    return hashlib.sha256(data.encode()).hexdigest()


def lambda_handler(event, context):
    try:
        logger.info(f"Incoming event: {json.dumps(event)}")

        body = json.loads(event.get("body", "{}"))

        user_id = body.get("user_id")
        sensitive_value = body.get("sensitive_data")

        if not user_id or not sensitive_value:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Missing required fields"})
            }

        # Tokenize sensitive field
        tokenized_value = tokenize_sensitive_data(sensitive_value)

        # Retrieve secret (example usage)
        secret_value = get_secret(SECRET_NAME)

        # Store record in DynamoDB
        table.put_item(
            Item={
                "user_id": user_id,
                "tokenized_data": tokenized_value,
                "created_at": datetime.utcnow().isoformat()
            }
        )

        logger.info("Data stored successfully")

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Data processed securely",
                "user_id": user_id
            })
        }

    except Exception as e:
        logger.error(f"Unhandled error: {str(e)}")

        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal server error"})
        }