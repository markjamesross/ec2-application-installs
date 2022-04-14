#Build basic VPC with only public subnets to avoid cost of NAT gateways
#Wouldn't recommend this set-up for productive use
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ec2-app-install-demo-vpc"
  cidr = "10.0.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support = true

  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

