
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
  default = ["subnet-d3c3b7a9"]
}

variable "us-east-2c-subnet-ids" {
  type = list(string)
  default = ["subnet-9ef12ed2"]
}

variable "security-groups-template" {
  type = list(string)
  default = ["sg-9301b6fd"]
}

