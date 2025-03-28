# Declaring an empty variable
variable "fruits" {}

output "apple_op" {
  value = var.fruits
}

output "apple_op_x" {
  value = "Apples are ${var.fruits["apple"]["color"]} in color and its taste is ${var.fruits["apple"]["taste"]} and its price is ${var.fruits["apple"]["price"]} per ${var.fruits["apple"]["metric"]}"
}

output "grapes_op_x" {
  value = "Grapes are ${var.fruits["grapes"]["color"]} in color and its taste is ${var.fruits["grapes"]["taste"]} and its price is ${var.fruits["grapes"]["price"]} per ${var.fruits["grapes"]["metric"]}"
}

output "blackberry_op_x" {
  value = "Blackberries are ${var.fruits["blackberry"]["color"]} in color and its taste is ${var.fruits["blackberry"]["taste"]} and its price is ${var.fruits["blackberry"]["price"]} per ${var.fruits["blackberry"]["metric"]} and their country of origin is ${var.fruits["blackberry"]["country"]}"
}

# What will when you attempt to access a property that's not defined