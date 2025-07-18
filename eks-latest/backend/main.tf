provider "aws" {
  region = "ap-south-1"
}



resource "aws_s3_bucket" "example" {
  bucket = "terraend-bucket-testing-sudlai"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "baic_dynamodb_table" {
  name           = "terralocksudalai"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terralocksudalai"
    Environment = "production"
  }
}