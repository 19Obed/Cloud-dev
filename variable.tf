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


variable "private-sub-cidr" {
  type        = string
  description = "Name of private subnet cidr"
  default     = "10.0.2.0/24"

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

variable "ASG_instance_type" {
  type        = string
  description = "autoscaling  launch configuration instance type"
  default     = "t2.micro"
}

variable "ELB" {
  type        = string
  description = "load balancer type"
  default     = "application"
}

variable "engine" {
  type        = string
  description = "DB engine type"
  default     = "mysql"
}

variable "instance_class" {
  type        = string
  description = "DB instance class"
  default     = "db.t2.micro"
}

variable "PGN" {
  type        = string
  description = "group name of parameter"
  default     = "default.mysql5.7"
}

variable "identifier" {
  type        = string
  description = "database identifier"
  default     = "rc-database"
}

