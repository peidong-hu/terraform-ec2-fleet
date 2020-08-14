terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

#resource "aws_ebs_volume" "ma_vol1" {
#  availability_zone = "us-east-2a"
#  size = 1
#  multi_attach_enabled = "true"
#  type = "io1"
#}

resource "aws_launch_template" "launchfleet1" {
  name_prefix   = "ecofleet"
  image_id      = "ami-007e9fbe81cfbf4fa"
  instance_type = "t3.micro"
}

resource "aws_ec2_fleet" "fleeteco" {
  launch_template_config {
    launch_template_specification {
      launch_template_id = aws_launch_template.launchfleet1.id
      version            = "$Latest"
    }
    override {
      availability_zone = "us-east-2b"
      instance_type = "t3.micro"
      subnet_id = "subnet-d3c3b7a9"
#      weighted_capacity = 3 
    }

    override {
      availability_zone = "us-east-2c"
      instance_type = "t3.micro"
      subnet_id = "subnet-9ef12ed2"
#      weighted_capacity = 2
    }
  }
  spot_options {
    allocation_strategy = "diversified"
  }
  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = 6 
    on_demand_target_capacity    = 1
    spot_target_capacity         = 5
  }
}
