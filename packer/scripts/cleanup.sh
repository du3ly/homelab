#!/bin/bash -eux

shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
ssh-keygen -A

rm -rf /etc/udev/rules.d/70-persistent-net.rules
touch /etc/udev/rules.d/70-persistent-net.rules
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev /var/lib/dhcp3/* /var/lib/dhcp/*

rm -rf *.iso
rm -rf /var/tmp/* /tmp/*
rm -rf /var/lib/cloud/instances/*
rm -rf /opt/ansible-venv



rm -f /var/lib/cloud/instance

for user in root; do rm -rf /home/$user/{.viminfo,.bash_history,.ssh} ; done

find /var/log -type f -exec /bin/rm -f {} \;

touch /var/log/lastlog
history -c
history -w
