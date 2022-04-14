resource "null_resource" "start_pipeline" {

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
aws imagebuilder start-image-pipeline-execution --image-pipeline-arn ${aws_imagebuilder_image_pipeline.ec2_ami.arn}
EOF
  }
}