terraform {
  backend "s3" {
    bucket         = "demodev0845"
    key            = "terraform/backend"
    region         = "us-east-1"
  }
}
