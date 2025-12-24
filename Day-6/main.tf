provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}

lookup(...): This function searches the map:
It looks at the instance_type map.
It uses the current workspace name as the key.
"t2.micro": This is the default value. If you are in a workspace that isn't in the map (like experimental), 
it will fall back to a cheap t2.micro.
