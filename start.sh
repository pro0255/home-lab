git clone https://github.com/pro0255/home-lab.git
cd home-lab
chmod +x *.sh

./update-vm.sh
./download-docker.sh

docker network create homelab


./create-structure.sh
./deploy-portainer.sh
