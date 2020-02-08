terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
}
