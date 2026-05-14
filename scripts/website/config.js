// Configuration for AWS services

const appConfig = {
    // AWS Cognito configuration
    cognito: {
        userPoolId: 'REGION_USER_POOL_ID', // e.g., us-east-1_xxxxxxxxx
        userPoolClientId: 'YOUR_APP_CLIENT_ID', // e.g., xxxxxxxxxxxxxxxxxxxxxxxxxx
        region: 'us-east-1' // e.g., us-east-1
    },
    // API Gateway configuration
    api: {
        baseUrl: 'https://YOUR_API_GATEWAY_ID.execute-api.us-east-1.amazonaws.com/prod'
    }
};
