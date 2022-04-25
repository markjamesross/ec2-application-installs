variable env_name {
  type = string
  description = "apps migration poc"
}
variable deployment_tool {
  type = string
  description = "Tool used to deploy code"
}
variable service_name {
  description = "Name of the service"
  type = string
  default = "packer_demo_ec2"
}
variable repository_name {
  description = "Name of the GitHub Repository."
  type        = string
}