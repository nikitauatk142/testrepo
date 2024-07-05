resource "aws_instance" "app" {
  ami           = var.AMIS
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  provisioner "local-exec" {
    command = <<EOT
      sleep 60
      ansible-playbook -i '${self.public_ip},' --private-key ~/.ssh/id_rsa playbook.yml
    EOT
  }
}



output "app_ip" {
  value = aws_instance.app.public_ip
}