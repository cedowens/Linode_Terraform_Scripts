terraform {
	required_providers {
		linode = {
			source = "linode/linode"
			version = "1.14.3"
		}
	}
}

provider "linode" {
  token = "mylinodetoken"
}

resource "linode_instance" "myc2-1" {
	image = "linode/ubuntu20.04"
	label = "myc2-1"
	region = "us-west"
	type = "g6-nanode-1"
	authorized_keys = [chomp(file("publickeyhere"))]	
	connection {
		host = self.ip_address
		user = "root"
		type = "ssh"
		private_key = chomp(file("privatekeyhere"))
		timeout = "2m"
	}

	provisioner "remote-exec" {
        inline = [
                "sudo apt-get update",
                "sudo apt-get -y install curl",
                "sudo apt-get -y install ufw",
		"sudo ufw default allow outgoing",
		"sudo ufw allow from 127.0.0.1 to any port 22",
		"sudo ufw allow from 127.0.0.1 to any port 3333",
		"sudo ufw allow 80",
		"sudo ufw allow 443",
		"sudo ufw --force enable",
		"sudo apt install -y docker.io",
		"sudo wget 'https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)' -O /usr/local/bin/docker-compose",
		"sudo chmod +x /usr/local/bin/docker-compose",
		"sudo apt install net-tools",
		"sudo apt-get install git",
		"sudo apt install -y golang-go",
      		"mkdir /tools && cd /tools && git clone https://github.com/cedowens/gophish",
		"sudo sed -i -e 's|#   PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/ssh_config",
		"sudo sed -i -e 's|    GSSAPIAuthentication yes|    GSSAPIAuthentication no|g' /etc/ssh/ssh_config",
		"sudo systemctl restart sshd",
        ]
}

}
