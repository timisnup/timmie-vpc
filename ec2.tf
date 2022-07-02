resource "aws_instance" "example" {
  ami                         = "ami-0fb391cce7a602d1f"
  key_name                    = "goodclass"
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2b"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-sub-1.id
  security_groups             = ["allow_tls"]
  tags = {
    Name = "timmie-ec2"
  }
}