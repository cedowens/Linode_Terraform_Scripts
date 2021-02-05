# Linode Terraform Scripts

Bash and Terraform scripts to automate standing up hosts in Linode. 

FYI: Each instance stood up is an Ubuntu 20 DigitalOcean instance (you can change this in the .tf file)

The scripts were built to be run on either Linux or macOS hosts. The scripts will first check to see if you have installed terraform and if not, it will attempt to install it for you before proceeding.

**NOTE: It is recommended that after running any of the scripts below to stand up your infra that you then ssh into your host, create a local user with sudo, and run any tools as that user. Running tools as root is not recommended**

## Prerequisites

- homebrew (macOS)

- You will need to setup a Linode Personal Access Token (can be done via the web admin console "API Tokens" page). Terraform uses this token in order to interface with Linode.

- You will also need to generate a public and private ssh key pair, which will be loaded by the script and used to ssh into your Linode host

## Instructions

> chmod +x *.sh

> ./[name of bash script you want to run]

### Info on the types of scripts included

#### 1. run-linode-behind-firewall.sh
This script will set up a linode host with a ufw firewall to restrict ssh access only to the IP you provide in the script. The script will also take an IP for a redirector to only allow that IP to access ports 80 and 443. If you do not plan to use a redirector, you can edit the .tf script accordingly and add "sudo ufw allow 80" and "sudo ufw allow 443". The script will also pull down docker, docker compose, and my C2_Cradle tool which contains a handful of dockerized C2 images.


#### 2. run-linode-with-evilginx2.sh
This script will set up a linode host with a ufw firewall to restrict ssh access only to the IP you provide in the script. This script will set ufw to allow open access to ports 80 and 443, which are used as part of running EvilGinx2. The script will also pull down docker, docker compose, and EvilGinx2 to the /tools directory.


#### 3. run-linode-with-gophish.sh
This script will set up a linode host with a ufw firewall to restrict ssh access and gophish's default port 3333 admin server access only to the IP you provide in the script. This script will set ufw to allow open access to ports 80 and 443, which may be used as part of running GoPhish. The script will also pull down docker, docker compose, and my slightly edited version of gophish to the /tools directory.
