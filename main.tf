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
  vpc_security_group_ids = var.security-groups-template
}

resource "aws_ec2_fleet" "fleet-eco-zonec" {
  count = length(var.us-east-2c-subnet-ids)
  launch_template_config {
    launch_template_specification {
      launch_template_id = aws_launch_template.launchfleet1.id
      version            = "$Latest"
    }

    override {
      availability_zone = "us-east-2c"
      instance_type = "t3.micro"
      subnet_id = var.us-east-2c-subnet-ids[count.index]
    }
  }
  spot_options {
    allocation_strategy = "diversified"
  }
  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = 5
    on_demand_target_capacity    = 1
    spot_target_capacity         = 4
  }
}


resource "aws_ec2_fleet" "fleet-eco-zoneb" {
  count = length(var.us-east-2b-subnet-ids)
  launch_template_config {
    launch_template_specification {
      launch_template_id = aws_launch_template.launchfleet1.id
      version            = "$Latest"
    }
    override {
      availability_zone = "us-east-2b"
      instance_type = "t3.micro"
      subnet_id = var.us-east-2b-subnet-ids[count.index]
    }

  }
  spot_options {
    allocation_strategy = "diversified"
  }
  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = 5 
    on_demand_target_capacity    = 1
    spot_target_capacity         = 4
  }
}
