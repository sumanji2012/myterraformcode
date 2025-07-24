variable "aws_region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket to store Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
}

