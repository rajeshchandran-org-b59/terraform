resource "null_resource" "main" {
  count = 3
}

variable "veggies" {
  default = ["cauliflower", "carrot", "cucumber"]
}

resource "null_resource" "this" {
  count = length(var.veggies)
}