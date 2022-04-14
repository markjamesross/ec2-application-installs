output ec2_role {
    value = aws_iam_role.role.name
}

output vpc_id {
    value = module.vpc.vpc_id
}

output sg_id {
    value = module.sg.security_group_id
}