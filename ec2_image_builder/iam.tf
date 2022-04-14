#Create Instance Profile for EC2 Systems Manager
resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2_image_builder_role"
  role = aws_iam_role.role.name
}

#Create Role that can be assumed by EC2
resource "aws_iam_role" "role" {
  name = "ec2_image_builder_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": [
                 "imagebuilder.amazonaws.com",
                 "ec2.amazonaws.com"
                ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

#Attach SSM Roles
resource "aws_iam_role_policy_attachment" "test-attach1" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
}
resource "aws_iam_role_policy_attachment" "test-attach2" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
}
resource "aws_iam_role_policy_attachment" "test-attach3" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}