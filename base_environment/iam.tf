#Create Instance Profile for EC2 Systems Manager
resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2_ssm_role"
  role = aws_iam_role.role.name
}

#Create Role that can be assumed by EC2
resource "aws_iam_role" "role" {
  name = "ec2_ssm_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

#Attach SSM Role
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}