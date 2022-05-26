terraform {
  backend "s3" {
    bucket         = "smn-tokyo-demo-terraform"
    key            = "terraform.demo.tokyo.tfstate"
    dynamodb_table = "demo-terraform-state-lock"

    region = "ap-northeast-1"
  }
}
