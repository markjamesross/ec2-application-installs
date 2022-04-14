# ec2-application-installs
Options for deploying applications onto EC2 instances

Build the pre-requisite network and SSM role: -
 - cd base_environment
 - terraform init
 - tarrform apply -var-file="../variables.tfvars"

Build the Packer Image: -
 - cd ../packer_image_builder
  - packer init .
  - packer build .

Test building an EC2 Instance from the new Packer AMI: -
  - cd ../
  - terraform init
  - tarrform apply -var-file="../variables.tfvars"
  - Find public IP of the built instance and check you can connect via http (should get a customer NGINX page that mentions Packer)