variable "project_name" {
  description = "The project name"
  default = "dcsg"
}

variable "environment" {
  description = "The environment"
  default = "testing"
}

variable "vpc_cidr_block" {
  description = "The cidr block (default: 10.0.0.0/16)"
  default = "10.0.0.0/16"
}

variable "subnet_az_1-cidr" {
  description = "The subnet in az #1 cidr block (default: 10.0.1.0/24)"
  default = "10.0.1.0/24"
}

variable "subnet_az_1-az_name" {
  description = "The subnet az #1 name"
  default = "us-east-1a"
}

variable "subnet_az_2-cidr" {
  description = "The subnet in az #2 cidr block (default: 10.0.2.0/24)"
  default = "10.0.2.0/24"
}

variable "subnet_az_2-az_name" {
  description = "The subnet az #2 name"
  default = "us-east-1b"
}

variable "subnet_az_3-cidr" {
  description = "The subnet in az #1 cidr block (default: 10.0.3.0/24)"
  default = "10.0.3.0/24"
}

variable "subnet_az_3-az_name" {
  description = "The subnet az #3 name"
  default = "us-east-1c"
}

variable "subnet_az_4-cidr" {
  description = "The subnet in az #4 cidr block (default: 10.0.4.0/24)"
  default = "10.0.4.0/24"
}

variable "subnet_az_4-az_name" {
  description = "The subnet az #4 name"
  default = "us-east-1e"
}

# Ubuntu Precise 12.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-de7ab6b6"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-21f78e11"
  }
}

variable "aws_region" {
  description = "The AWS region"
  default = "us-east-1"
}