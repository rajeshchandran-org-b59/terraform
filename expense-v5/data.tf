data "aws_route53_zone" "main" {
  name         = "rajeshapps.site"
  private_zone = false
}

data "aws_security_group" "main" {
  name = "b59-security-group"
}

data "aws_ami" "main" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name = "b59-LabImage-Rajesh"
  }
}