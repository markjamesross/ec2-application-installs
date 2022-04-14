data "template_file" "ec2_image_builderfile" {
  template = file("${path.module}/source/ec2_image_builder.tf")
  vars = {
    security_group_id = module.sg.security_group_id
    subnet_id = module.vpc.public_subnets[0]
  }
}

resource "local_file" "ec2_image_builderfile" {
    content  = data.template_file.ec2_image_builderfile.rendered
    filename = "${path.module}/../ec2_image_builder/ec2_image_builder.tf"
}

data "template_file" "image_builder_ec2" {
  template = file("${path.module}/source/image_builder_demo_ec2.tf")
  vars = {
    vpc_security_group_ids = module.sg.security_group_id
    subnet_id              = module.vpc.public_subnets[0]
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  }
}
resource "local_file" "image_builder_ec2" {
    content  = data.template_file.image_builder_ec2.rendered
    filename = "${path.module}/../image_builder_demo_ec2/ec2.tf"
}
