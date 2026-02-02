variable "availability_zone-1" {
  default = "us-west-1a"
}

variable "availability_zone-2" {
    default = "us-west-1b"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr-1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr-2" {
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr-1" {
  default = "10.0.3.0/24"
}

variable "private_subnet_cidr-2" {
  default = "10.0.4.0/24"
}

variable "enableens_support" {
  type = bool
  default = true
}