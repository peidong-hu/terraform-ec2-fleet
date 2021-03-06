
variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

# Ubuntu Precise 18.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-2 = "ami-007e9fbe81cfbf4fa"
  }
}

variable "us-east-2b-subnet-ids" {
  type = list(string)
  default = ["subnet-d3c3b7a9"] #US-EAST-2B-SUBNET-IDS
}

variable "us-east-2c-subnet-ids" {
  type = list(string)
  default = ["subnet-9ef12ed2"] #US-EAST-2C-SUBNET-IDS
}

variable "security-groups-template" {
  type = list(string)
  default = ["sg-9301b6fd"]  #SG-IN-TEMPLATE
}

variable "ins-type" {
  default = "t3.micro" #INS_TYPE
}

variable "ami-id" {
  default = "ami-007e9fbe81cfbf4fa" #AMI-ID
}

variable "bzone-total" {
  default = 5 #BZONE-TOTAL
}

variable "bzone-spot-count" {
  default = 4 #BZONE-SPOT-COUNT
}

variable "bzone-ondemand-count" {
  default = 1 #BZONE-ONDEMAND-COUNT
}

variable "czone-total" {
  default = 5 #CZONE-TOTAL
}

variable "czone-spot-count" {
  default = 4 #CZONE-SPOT-COUNT
}

variable "czone-ondemand-count" {
  default = 1 #CZONE-ONDEMAND-COUNT
}

variable "multi-attach-uuid" {
  default = "uuid" #MULTI-ATTACH-UUID
}
