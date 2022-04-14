module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "image_builder-demo-instance"
  iam_instance_profile = "${iam_instance_profile}"
  ami                    = data.aws_ami.image_builder_ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${vpc_security_group_ids}"]
  subnet_id              = "${subnet_id}"
}

data "aws_ami" "image_builder_ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["ec2_ami_recipe*"]
  }
}