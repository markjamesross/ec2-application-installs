data "template_file" "ec2_userdata_file" {
  template = file("${path.module}/source/userdata_demo_ec2.tf")
  vars = {
    security_group_id = module.sg.security_group_id
    subnet_id = module.vpc.public_subnets[0]
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  }
}

resource "local_file" "ec2_userdata_file" {
    content  = data.template_file.ec2_userdata_file.rendered
    filename = "${path.module}/../user_data/userdata_demo_ec2.tf"
}