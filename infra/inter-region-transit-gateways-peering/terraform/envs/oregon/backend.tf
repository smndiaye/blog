terraform {
  backend "s3" {
    bucket         = "smn-oregon-demo-terraform"
    key            = "terraform.demo.oregon.tfstate"
    dynamodb_table = "demo-terraform-state-lock"

    region = "us-west-2"
  }
}
