data "template_file" "packer_file" {
  template = file("${path.module}/source/packer_file.pkr.hcl")
  vars = {
    aws_region = data.aws_region.current.name
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.public_subnets[0]
  }
}

resource "local_file" "packer_file" {
    content  = data.template_file.packer_file.rendered
    filename = "${path.module}/../packer_image_builder/packer_file.pkr.hcl"
}

data "template_file" "packer_ec2" {
  template = file("${path.module}/source/packer_demo_ec2.tf")
  vars = {
    vpc_security_group_ids = module.sg.security_group_id
    subnet_id              = module.vpc.public_subnets[0]
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  }
}
resource "local_file" "packer_ec2" {
    content  = data.template_file.packer_ec2.rendered
    filename = "${path.module}/../packer_demo_ec2/ec2.tf"
}
