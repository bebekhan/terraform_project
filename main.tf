resource "aws_instance" "bbzexample" {
  ami		= "ami-40d28157"
  instance_type = "t2.micro"

  tags {
    Name = "terraform-single-example"

  }  
}

