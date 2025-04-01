variable "componets" {
  default = {
    frontend = {
      instance_type = "t3.micro"
      ami           = "ami-0fcc78c828f981df2"
    }

    mysql = {
      instance_type = "t3.medium"
      ami           = "ami-0fcc78c828f981df2"
    }
    backend = {
      instance_type = "t2.micro"
      ami           = "ami-0fcc78c828f981df2"
    }
    tracking = {
      # instance_type = ""
      ami = "ami-0fcc78c828f981df2"
    }
  }
}
resource "aws_instance" "main" {
  for_each = var.componets

  ami = each.value["ami"]
  # instance_type          = each.value["instance_type"] == ".*" ? each.value["instance_type"] : "t3.nano"
  instance_type          = try(each.value["instance_type"], null) == null ? "t3.nano" : each.value["instance_type"]
  vpc_security_group_ids = ["sg-0b37bb6b6f027ffc5"]

  tags = {
    Name = each.key
  }
}

