resource "aws_instance" "naheemah_app" {
  ami             = "ami-0e80e7e160cbfbc53"
  instance_type   = "t3.micro"
  key_name        = "Ajay_devs"
  security_groups = [aws_security_group.naheemah_app_sg.name]
  tags = {
    Name = "naheemah-app"
  }
  user_data = file("userdata.sh")
}