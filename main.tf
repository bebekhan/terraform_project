provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "bbzexample" {
  ami		= "ami-40d28157"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags {
    Name = "terraform-single-example"
  }  
}

resource "aws_security_group" "instance" {
  name = "terraform-single-example"

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.bbzexample.public_ip}"
}


