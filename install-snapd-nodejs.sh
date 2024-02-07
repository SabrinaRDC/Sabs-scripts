ResetColor='\033[0m'
IGreen='\033[0;92m'
ICyan='\033[0;96m'

echo -e "${ICyan}Updating repository${ResetColor}"
sudo apt update
echo -e "${ICyan}Upgrading packages${ResetColor}"
sudo apt upgrade -y
echo -e "${ICyan}Installing snapd${ResetColor}"
sudo apt install snapd -y
echo -e "${ICyan}Installing hello-world${ResetColor}"
sudo snap install hello-world
hello-world

## UNFINISHED
