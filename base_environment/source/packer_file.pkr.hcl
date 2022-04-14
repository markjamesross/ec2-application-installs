packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name                    = "packer-demo-ami"
  ami_description             = "example ami built with packer"
  associate_public_ip_address = true
  subnet_id                   = "${subnet_id}"
  vpc_id                      = "${vpc_id}"
  instance_type               = "t3.micro"
  region                      = "${aws_region}"
  ssh_interface               = "public_ip"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "packer-demo-ami"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]
  }
  provisioner "file" {
    source = "packer_index.html"
    destination = "/tmp/index.html"
  }
  provisioner "shell" {
    inline = [
      "sudo cp /tmp/index.html /var/www/html/index.nginx-debian.html"
    ]
  }
}

