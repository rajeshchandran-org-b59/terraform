resource "aws_instance" "main" {

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = var.name
  }
}


resource "null_resource" "main" {
  depends_on = [aws_route53_record.main] # This ensure, provisioner will only be exectued post dns_record creation
  # triggers = {
  #   timestamp = timestamp() # Forces execution on every apply
  # }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.main.private_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 10",
      "pip3.11 install ansible",
      "ansible-pull -U https://github.com/B59-CloudDevOps/learn-ansible.git -e env=${var.env} -e component=${var.name} expense-pull.yaml"
    ]
  }
}

resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = "${var.name}-${var.env}.clouding-app.shop"
  type    = "A"
  ttl     = 10
  records = [aws_instance.main.private_ip]
}

