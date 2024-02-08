provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.subnet_id_value

   connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
  
}