resource "aws_instance" "naheemah_app" {
  ami           = "ami-0e80e7e160cbfbc53"
  instance_type = "t3.micro"
  key_name      = "Ajay_devs"
  tags = {
    Name = "naheemah-app"
  }

}