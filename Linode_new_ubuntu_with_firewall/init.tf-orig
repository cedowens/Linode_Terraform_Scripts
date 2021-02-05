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
		"sudo ufw allow from 10.0.0.0 to any port 80",
		"sudo ufw allow from 10.0.0.0 to any port 443",
		"sudo ufw --force enable",
		"sudo apt install -y docker.io",
		"sudo systemctl enable docker --now",
		"sudo wget 'https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)' -O /usr/local/bin/docker-compose",
		"sudo chmod +x /usr/local/bin/docker-compose",
		"sudo apt-get install git",
		"git clone https://github.com/cedowens/C2_Cradle",
        ]
}

}
