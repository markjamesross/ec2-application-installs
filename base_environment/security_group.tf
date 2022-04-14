module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2-app-install-demo security-group"
  description = "Security group for demoing EC2 app installs"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "all out"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "all out"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}