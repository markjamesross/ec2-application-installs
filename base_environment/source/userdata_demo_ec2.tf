module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "userdata-demo-instance"
  iam_instance_profile = "${iam_instance_profile}"
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${security_group_id}"]
  subnet_id              = "${subnet_id}"
  user_data = file("source/userdata.tpl")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}