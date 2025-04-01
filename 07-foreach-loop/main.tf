variable "fruits" {
  default = {
    apple = {
      color  = "red"
      taste  = "sweet"
      price  = 100
      metric = "kg"
    }
    grapes = {
      color  = "green"
      taste  = "sour"
      price  = 200
      metric = "kg"
    }
    # blackberry = {
    #   color   = "black"
    #   taste   = "sweet"
    #   price   = 300
    #   metric  = "kg"
    #   country = "India"
    # }
  }
}

resource "null_resource" "main" {
  for_each = var.fruits
}