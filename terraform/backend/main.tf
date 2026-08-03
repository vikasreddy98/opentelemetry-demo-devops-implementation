provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "backend" {
  bucket = "terraform-eks-state-bucket-2099"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name         = "terraform-eks-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}