variable "vpc-cidr" {
  type        = string
  description = "Name of vpc cdr"
  default     = "10.0.0.0/16"

}

variable "public-sub-cidr" {
  type        = string
  description = "Name of public subnet cidr"
  default     = "10.0.1.0/24"

}

variable "public-sub-cidr_2" {
  type        = string
  description = "Name of public subnet cidr_2"
  default     = "10.0.2.0/24"

}

variable "private-sub-cidr" {
  type        = string
  description = "Name of private subnet cidr"
  default     = "10.0.3.0/24"

}

variable "private-sub-cidr_2" {
  type        = string
  description = "Name of private subnet cidr_2"
  default     = "10.0.4.0/24"

}
variable "az1" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-2a"

}

variable "az2" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-2b"

}

variable "az3" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-2b"

}

variable "az4" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-2c"

}

variable "providerAZ" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-2"

}

variable "ami_version" {
  type        = string
  description = "Name of ami version"
  default     = "ami-0d729d2846a86a9e7"

}

variable "instance_type" {
  type        = string
  description = "Name of instance type"
  default     = "t2.micro"

}

variable "snapshot_identifier" {
  type        = string
  description = "Name of snapshot identifier"
  default     = "arn:aws:rds:eu-west-2:366536524979:snapshot:my-snapshot"
}

variable "Key-name" {
  type        = string
  description = "Name of key name"
  default     = "obed-key"
}

variable "ami-id" {
  type        = string
  description = "name of ami ID"
  default     = "[ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20220609]"
}


