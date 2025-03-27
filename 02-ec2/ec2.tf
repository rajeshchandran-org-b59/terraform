resource "aws_instance" "main" {
  # ami           = "ami-0fcc78c828f981df2"
  ami           = "ami-072983368f2a6eab5"
  instance_type = "t3.micro"

  tags = {
    Name = "terra"
  }
}