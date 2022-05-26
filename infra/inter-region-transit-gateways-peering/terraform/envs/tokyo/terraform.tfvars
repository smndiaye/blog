account = "tgw-demo-tokyo"
env     = "dev"
region  = "ap-northeast-1"

cidr_block         = "10.1.0.0/16"
availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
allowed_ips = [
  {
    type  = "IPV4"
    value = "" // My IP
  }
]

bastion_ami_id        = "ami-0701e21c502689c31"
bastion_instance_type = "t2.nano"
ssh_public_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7m6eyn7Z2S+WAtafoiTHb7y8Gn+ly8F7wWfDQMM7GhroJeD//ENhpNO9rUfa1arLH5Cd/bGJNh5/dR95XxqOWNjcQeUyA/2l3gUp5NjVn2GtfyMrI0cNYbpEiqoGf5Y3x6ZlJkSX8S4JZQfpMbeKIKfC0lmbtpNZ79KWgJHKnZRySGMHN8+ymr15UpeWUwhgJ6tGTbuQzp3nizvOqvdvhrMY5lVnzsApzKTrxFROhVI4tCHUGDqt2udEYMziKWMFe2p1CcJd3enbAqDDJegekiQHqFS3A6gaaG7lzkbr7ir+1uApjNyHhWTJwI40NSUmyTotsY/lXnPZs37Gu19vTklcSQvZZfz4WwmLGQaxr4/UqM7TJStp86okt7XU2zNT/5vu1lMLl1oGXfxAlwWfdoxs1a2wX/g9j4MYNtfNeKZ5BGgx8Bqpn89CQ4aMdr43XPellcafMSiN9uZf9n55b2lGf7ZkS+j7fl/DGxU4q3MfvOGKOrwOTBglYtuOrN3k= serigne_ndiaye@ML-00663.local"

other_side_tgw = {
  id                    = "" ## needed since request is made from this side (Oregon)
  region                = "us-west-2"
  account_id            = ""
  cidr_block            = "10.2.0.0/16"
  peering_attachment_id = ""
}
