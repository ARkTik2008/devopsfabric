#!/bin/bash
#
# A script that creates users.
# Usage: sudo ./user_add.sh <login> <password_hash> <Name> <Surname>

# Checking number of arguments, script should contain 4
if [ $# -eq 4 ]; then
USER=$1
PASSWD_HASH=$2
USER_NAME=$3
USER_SURNAME=$4

# Checking for user exists
grep -q "$USER" /etc/passwd
if [ $? -eq 0 ]; then
  echo "User $USER already exists"
  echo "Please choose another login"
  exit 1
fi

# Adding user
useradd -m -d /home/"$USER" -p "$PASSWD_HASH" \
  -c "$USER_NAME $USER_SURNAME" -s /bin/bash "$USER"
mkdir /home/"$USER"/.ssh
touch /home/"$USER"/.ssh/authorized_keys
echo "$SSHPUBKEY" >> /home/"$USER"/.ssh/authorized_keys
chmod -R 700 /home/"$USER"/.ssh
chmod -R 600 /home/"$USER"/.ssh/authorized_keys
chown -R "$USER":"$USER" /home/"$USER"/.ssh

else
  echo "The script needs 4 arguments, but you had given $#"
  echo "Usage: sudo ./user_add.sh <login> <password_hash> <Name> <Surname>"
fi
