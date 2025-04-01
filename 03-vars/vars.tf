# Supported datatypes in terraform
# 1) Numbers 
# 2) Boolents 
# 3) Strings

# variable "a" {}  # This is how you define an emoty variable

variable "a" {
  default = 10 # This is how you define a variable with default value 
}

output "op" {   # This is how you print an output variable
  value = var.a # This is how we can access a variable
}

output "op_x" {
  value = "Value of a is ${var.a}"
}

# List variable 
variable "sample_list" {
  default = [
    "terraform",
    true,
    5000,
  ]
}

output "sample_op" {
  value = var.sample_list
}

output "sample_op_x" {
  value = "${var.sample_list[1]} is a popular IAC Tool and it supports more than ${var.sample_list[0]} providers and its ${var.sample_list[2]} "
}

# Map Variable
variable "sample_map" {
  description = "Sample map variable"
  default = {
    name       = "Mike",
    type       = "DevOps",
    department = "Engineering",
    salary     = 10000
  }
}

output "sample_map_op" {
  value = var.sample_map
}

output "sample_map_op_x" {
  value = "${var.sample_map["name"]} is a ${var.sample_map["type"]} engineer and his salary is ${var.sample_map["salary"]}"
}

# Accessing a variable from a file.  
# If you want access a variable, you need to declare the empty variable file 
variable "state" {}

output "state_op" {
  value = var.state
}

variable "environment" {}
output "environment_op" {
  value = "Current environment is ${var.environment}"
}