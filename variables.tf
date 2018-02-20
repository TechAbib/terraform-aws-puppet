variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "eu-west-2"
}

variable "aws_region_azs" {
    description = "EC2 Region for the VPC"
    default = {
        eu-west-2 = "eu-west-2a"
    }
}

variable "ubuntu_1604_amis" {
    description = "Ubuntu 16.04 AMIs by region"
    default = {
        eu-west-2 = "ami-941e04f0" # ubuntu 16.04 LTS
    }
}

variable "amz_linux_2_amis" {
    description = "Amazon Linux 2 AMIs by region"
    default = {
        eu-west-2 = "ami-6d263d09" # Amazon Linux 2 LTS
    }
}

variable "amz_nat_amis" {
    description = "Amazon Linux NAT AMIs by region"
    default = {
        eu-west-2 = "ami-fdd9c199" # Amazon Linux NAT
    }
}


variable "vpc_cidr" {
    description = "CIDR for VPC"
    default = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for Public Subnet"
    default = "10.10.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for Private Subnet"
    default = "10.10.1.0/24"
}
