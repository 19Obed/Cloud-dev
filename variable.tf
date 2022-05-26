variable "vpc-cidr" {
  type        = string
  description = "Name of vpc cdr"
  default     = "10.0.0.0/16"

}

variable "public-cidr" {
  type        = string
  description = "Name of public subnet cidr"
  default     = "10.0.1.0/24"

}

variable "public-cidr_2" {
  type        = string
  description = "Name of public subnet 2 cidr"
  default     = "10.0.2.0/24"

}

variable "public-cidr_3" {
  type        = string
  description = "Name of public subnet 3 cidr"
  default     = "10.0.3.0/24"

}

variable "private-cidr" {
  type        = string
  description = "Name of private subnet cidr"
  default     = "10.0.4.0/24"

}

variable "private-cidr_2" {
  type        = string
  description = "Name of private subnet 2 cidr"
  default     = "10.0.5.0/24"

}

variable "az1" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-1a"

}

variable "az2" {
  type        = string
  description = "Name of availabilty zone cidr"
  default     = "eu-west-1b"

}