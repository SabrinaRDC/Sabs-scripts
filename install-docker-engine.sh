ResetColor='\033[0m'
IGreen='\033[0;92m'
ICyan='\033[0;96m'
# Uninstall all conflicting packages
echo -e "${ICyan}Removing conflicting packages${ResetColor}"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt remove $pkg; done

# Add Docker's official GPG key:
echo -e "${ICyan}Updating repository${ResetColor}"
sudo apt update
echo -e "${ICyan}Installing ca-certificats & curl${ResetColor}"
sudo apt install ca-certificates curl
echo -e "${ICyan}Installing keyring${ResetColor}"
sudo install -m 0755 -d /etc/apt/keyrings
echo -e "${ICyan}Adding Docker's official GPG key${ResetColor}"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo -e "${ICyan}Adding Docker APT repository${ResetColor}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo -e "${ICyan}Updating repository${ResetColor}"
sudo apt update

# Install latest
echo -e "${ICyan}Installing Docker${ResetColor}"
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo -e "${IGreen}Docker Engine Installed${ResetColor}"

# Install fuse-overlayfs
echo -e "${ICyan}Installing fuse-overlayfs${ResetColor}"
sudo apt install fuse-overlayfs

# Change storage driver to fuse-overlayfs
mkdir /etc/docker
echo -e "${ICyan}touching daemon.json${ResetColor}"
touch /etc/docker/daemon.json
echo '{
  "storage-driver": "fuse-overlayfs"
}' > /etc/docker/daemon.json
echo -e "${IGreen}Storage driver changed to fuse-overlayfs${ResetColor}"

# Test hello-world
sudo docker run hello-world
