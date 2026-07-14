variable "ami" {
  description = "The ami ID to use for the imstance"
  type        = string
  default     = "ami-0e80e7e160cbfbc53"
}

variable "instance_type" {
  description = "type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "key pair name use for SSH access"
  type        = string
  default     = "Ajay_dev"
}

variable "environment" {
  description = "The environment for the instance e.g dev, QA, prod,"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
  default     = "vpc-084a10f473fb0a8bb"
}