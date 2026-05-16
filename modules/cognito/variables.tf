variable "tags" {
  type = map(string)
}

variable "callback_url" {
  type        = string
  description = "The CloudFront URL to redirect to after successful login"
}