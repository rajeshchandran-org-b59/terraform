data "aws_route53_zone" "main" {
  name         = "rajeshapps.site"
  private_zone = false
}

data "aws_security_group" "main" {
  name = "b59-allow-all"
}

data "aws_ami" "main" {
  most_recent = true

  owners = ["355449129696"]
  tags = {
    Name = "DevOps-LabImage-RHEL9"
  }
}