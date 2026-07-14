resource "aws_instance" "naheemah_app" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "Ajay_devs"
  security_groups = [aws_security_group.naheemah_app_sg.name]
  tags = {
    Name = "naheemah-app ${var.environment}"
  }
  user_data = file("userdata.sh")
}