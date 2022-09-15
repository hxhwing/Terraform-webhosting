# Configure the AWS Provider
provider "aws" {
   region  = var.region
}

## Specifies the S3 Bucket and DynamoDB table used for the durable backend and state locking
terraform {
    backend "s3" {
      bucket = "hxh-tokyo"
      key = "terraform-state/webhosting/terraform.tfstate"
      dynamodb_table = "terraform-state-lock"
      region = "ap-northeast-1"
  }
}