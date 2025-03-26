#!/bin/bash

#SOME COMMANDS YOU WANT TO EXECUTE

function rm_home_pi {
  if grep -r '/home/pi' $1
  then
	  grep -rl '/home/pi' $1 | xargs sed -i 's@/home/pi@'$(getent passwd 1000 | cut --delimiter=: --fields=6)'@g'
  fi
}

function rm_user_pi {
  if grep -r 'User=pi' $1
  then
	  grep -rl 'User=pi' $1 | xargs sed -i 's@User=pi@'User=$(getent passwd 1000 | cut --delimiter=: --fields=1)'@g'
  fi
}

# Replaces the path /home/pi for the current user.
rm_home_pi /etc/systemd/system
rm_home_pi $(getent passwd 1000 | cut --delimiter=: --fields=6)

# Replace user pi with the current user.
rm_user_pi /etc/systemd/system

# Deletes all pythoncache files, as the /home/pi entry may still exist.
find $(getent passwd 1000 | cut --delimiter=: --fields=6)/ -name '*.pyc' -delete

# The package cache is renewed using ansible.
ansible --extra-vars ansible_python_interpreter=/usr/bin/python3 \
  --inventory localhost, --connection local \
  --module-name apt \
  --args "update_cache=yes cache_valid_time=3600" localhost

localectl set-locale LANG=de_DE.UTF-8
export USER_HOME=$(getent passwd 1000 | cut --delimiter=: --fields=6)

if [ -d ${USER_HOME}/workspace/doitpi-ansible ]
then
  cd ${USER_HOME}/workspace/doitpi-ansible/
  # Run Playbook allways true
  ansible-playbook --limit $(hostname) --tags firstrun --skip-tags mybase main.yaml || true
  cd -
fi

# Deletion of the doitpi_firstboot service
systemctl disable doitpi_firstboot.service

rm -rf /etc/systemd/system/doitpi_firstboot.service
rm -f /doitpi_firstboot.sh

sleep 20

reboot
