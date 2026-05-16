output "website_url" {
  value       = module.s3.cloudfront_domain_name
  description = "The CloudFront URL for the website"
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.user_pool_client_id
}
