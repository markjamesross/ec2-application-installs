data "template_file" "ec2_ssm_file" {
  template = file("${path.module}/source/ssm_demo_ec2.tf")
  vars = {
    security_group_id = module.sg.security_group_id
    subnet_id = module.vpc.public_subnets[0]
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  }
}

resource "local_file" "ec2_ssm_file" {
    content  = data.template_file.ec2_ssm_file.rendered
    filename = "${path.module}/../systems_manager/ssm_demo_ec2.tf"
}