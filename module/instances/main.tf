# data source to get list AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Create Webservers
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id[0]
  vpc_security_group_ids = [var.web_security_group_id]
  //key_name               = var.key_name
  //user_data = "${file("install_jenkins.sh")}"

  tags = {
    Name = "${var.environment}-webserver"
  }
}