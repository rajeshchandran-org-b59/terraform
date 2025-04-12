resource "null_resource" "main" {}

output "main" {
  value = var.env
}