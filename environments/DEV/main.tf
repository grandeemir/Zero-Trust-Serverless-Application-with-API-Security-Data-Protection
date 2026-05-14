module "s3" {
  source = "../../modules/S3&CDN"
  tags   = local.common_tags
  bucket_name = "secure-file-vaulth-app-bucket"
}