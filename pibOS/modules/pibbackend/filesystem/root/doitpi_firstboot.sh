#!/bin/bash
#set -e
sleep 30 # Waiting for prober boot up

# Variable for the current user's home path
USER_HOME=$(getent passwd 1000 | cut --delimiter=: --fields=6)
USER_NAME=$(getent passwd 1000 | cut --delimiter=: --fields=1)
export APP_DIR="$USER_HOME/app"
export BACKEND_DIR="$APP_DIR/pib-backend"
export FRONTEND_DIR="$APP_DIR/cerebra"

# Function to replace the path /home/pi with the current user's home path
function rm_home_pi {
  # Check if the path /home/pi exists in the specified file or directory
  if grep -r '/home/pi' "$1"
  then
    # Replace all occurrences of /home/pi with the current user's home path
    grep -rl '/home/pi' "$1" | xargs sed -i "s@/home/pi@${USER_HOME}@g"
  fi
}

# Function to replace the user pi with the current user
function rm_user_pi {
  # Check if the user pi exists in the specified file or directory
  if grep -r 'User=pi' "$1"
  then
    # Replace all occurrences of User=pi with the current user
    grep -rl 'User=pi' "$1" | xargs sed -i "s@User=pi@User=${USER_NAME}@g"
  fi
}

# Replace the path /home/pi with the current user's home path in systemd services
rm_home_pi /etc/systemd/system
rm_home_pi ${USER_HOME}

# Replace the user pi with the current user in systemd services
rm_user_pi /etc/systemd/system

# Delete all Python cache files, as the /home/pi entry may still exist
find ${USER_HOME}/ -name '*.pyc' -delete

# Update the package cache using Ansible
ansible --extra-vars ansible_python_interpreter=/usr/bin/python3 \
  --inventory localhost, --connection local \
  --module-name apt \
  --args "update_cache=yes cache_valid_time=3600" localhost

# Set the locale to German (Germany)
localectl set-locale LANG=de_DE.UTF-8

# Check if the directory for the Ansible playbook exists
if [ -d ${USER_HOME}/workspace/doitpi-ansible ]
then
  # Change to the Ansible playbook directory
  cd ${USER_HOME}/workspace/doitpi-ansible/
  # Run the Ansible playbook, regardless of success or failure
  ansible-playbook --limit $(hostname) --tags firstrun --skip-tags mybase main.yaml || true
  # Return to the previous directory
  cd -
fi

# Change to the current user's home directory
cd ${USER_HOME}
# Check if the setup-pib.sh script does not exist in the current directory
if [ ! -f setup-pib.sh ]
then
  # Download the setup-pib.sh script from the specified URL if it doesn't exist
  wget https://raw.githubusercontent.com/pib-rocks/pib-backend/main/setup/setup-pib.sh
fi
# Change the ownership of the setup-pib.sh script to the current user
chown "${USER_NAME}": setup-pib.sh
# Switch to the current user and execute the setup-pib.sh script with debug output enabled
su --login --command "bash -x setup-pib.sh" "${USER_NAME}"

docker compose -f "$BACKEND_DIR/docker-compose.yaml" --profile all up -d || return 1
docker compose -f "$FRONTEND_DIR/docker-compose.yaml" up -d || return 1
# Disable the doitpi_firstboot service
systemctl disable doitpi_firstboot.service
# Delete the service file for doitpi_firstboot
rm -rf /etc/systemd/system/doitpi_firstboot.service
# Delete the first boot script
rm -f /doitpi_firstboot.sh
# Wait 20 seconds before rebooting the system
sleep 20
# Reboot the system
reboot
