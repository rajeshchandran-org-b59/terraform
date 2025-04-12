terraform {
  backend "s3" {
    bucket = "b59-tf-state-bucket-rajesh"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}