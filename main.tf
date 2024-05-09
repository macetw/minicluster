terraform {
  backend "s3" {
    bucket = "macetw-terraform"
    key    = "minicluster"
    region = "us-east-1"
  }
}

