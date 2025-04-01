module "app" {
  for_each               = var.componets
  source                 = "./app"
  ami                    = var.ami
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.main.id]
  name                   = each.key
  zone_id                = data.aws_route53_zone.main.id
  env                    = var.env
}
