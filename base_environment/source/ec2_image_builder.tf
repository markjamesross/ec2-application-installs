resource "aws_imagebuilder_image_pipeline" "ec2_ami" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.ec2_recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.ec2_ami.arn
  name                             = "ec2_ami_pipeline"
}

resource "aws_imagebuilder_image_recipe" "ec2_recipe" {
  block_device_mapping {
    device_name = "/dev/xvdb"
    ebs {
      delete_on_termination = true
      volume_size           = 8
      volume_type           = "gp2"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.install_nginx.arn
  }

  name         = "ec2_ami_recipe"
  parent_image = data.aws_ami.ubuntu.id
  version      = "0.0.1"
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

resource "aws_imagebuilder_component" "install_nginx" {
  data = file("source/install_nginx.yml")
  name     = "example"
  platform = "Linux"
  version  = "0.0.1"
}

resource "aws_imagebuilder_infrastructure_configuration" "ec2_ami" {
  description                   = "Infra cofig for EC2 AMI Build"
  instance_profile_name         = aws_iam_instance_profile.instance_profile.name
  instance_types                = ["t3.micro"]
  name                          = "ec2_ami"
  subnet_id                     = "${subnet_id}" #needs updating
  security_group_ids            = ["${security_group_id}"] #needs updating
  terminate_instance_on_failure = true
}

resource "aws_imagebuilder_distribution_configuration" "ec2_ami" {
  name = "ec2_ami_distibution"

  distribution {
    ami_distribution_configuration {
      name = "ec2-image-builder-demo-ami-{{ imagebuilder:buildDate }}"
    }

    region = data.aws_region.current.name
  }
}