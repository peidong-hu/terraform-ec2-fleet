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
  image_id      = var.ami-id
  instance_type = var.ins-type
  vpc_security_group_ids = var.security-groups-template
  tag_specifications {
    resource_type = "instance"

    tags = {
      multiVolAttach = var.multi-attach-uuid
    }
  }
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
      subnet_id = var.us-east-2c-subnet-ids[count.index]
    }

  }
  on_demand_options {
    allocation_strategy = "prioritized" 
  }

  spot_options {
    allocation_strategy = "diversified"
  }
  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = var.czone-total
    on_demand_target_capacity    = var.czone-ondemand-count
    spot_target_capacity         = var.czone-spot-count
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
      subnet_id = var.us-east-2b-subnet-ids[count.index]
    }

  }
  on_demand_options {
    allocation_strategy = "prioritized"
  }

  spot_options {
    allocation_strategy = "diversified"
  }
  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = var.bzone-total
    on_demand_target_capacity    = var.bzone-ondemand-count
    spot_target_capacity         = var.bzone-spot-count
  }
}
