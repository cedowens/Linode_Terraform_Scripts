#!/bin/bash

echo "*******************************************************************"
echo "  Welcome to the Terraform Script Runner to Set Up Your C2 Infra!  "
echo "*******************************************************************"
echo ""
echo "Have you already installed terraform? (Y/N)?"
read installed

if [[ ("$installed" ==  "N") || ("$installed" == "n") ]];then
	ostype=$(uname)
	if [[ "$ostype" == "Linux" ]]; then
		echo "attempting to install terraform (linux install)..."
		curl -o ~/terraform.zip https://releases.hashicorp.com/terraform/0.13.1/terraform_0.13.1_linux_amd64.zip
		mkdir -p ~/opt/terraform
		sudo apt install unzip
		unzip ~/terraform.zip -d ~/opt/terraform
		echo "Next add terraform to your path (append export PATH=$PATH:~/opt/terraform/bin to the end)"
		nano ~/.bashrc
		. .bashrc
	elif [[ "$ostype" == "Darwin" ]]; then
		echo "Attempting to install terraform (macOS Homebrew install)..."
		brew tap hashicorp/tap
		brew install hashicorp/tap/terraform
		
	fi
fi
echo "=====>Enter the name you want to call your Linode host"
read linodeName
echo "=====>Enter the src IP that you will login to your C2 infra from (i.e., terraform will set up a firewall only allowing ssh/admin access in from this src IP"
read adminIP
echo "=====>Enter your Linode Personal Access Token"
read linodeToken
echo "=====>Enter the local path to the ssh public key you want to load onto this host for ssh access (ex: ~/.ssh/id_rsa.pub)"
read pubKey
echo "=====>Enter the local path to the ssh private key that you want Terraform to use to ssh into this Linode host (ex: ~/.ssh/id_rsa)"
read privKey

cd Linode_new_ubuntu_with_evilginx2

sed -i -e "s/myc2-1/$linodeName/g" init.tf
sed -i -e 's|publickeyhere|'"$pubKey"'|g' init.tf
sed -i -e 's|privatekeyhere|'"$privKey"'|g' init.tf
sed -i -e "s/127.0.0.1/$adminIP/g" init.tf
sed -i -e "s/mylinodetoken/$linodeToken/g" init.tf

terraform init
echo "====>Running terraform plan for the new Linode host with ufw firewall..."
terraform plan 
echo "====>Applying the terraform plan..."
terraform apply
cp init.tf-orig init.tf
