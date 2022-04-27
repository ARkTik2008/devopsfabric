#!/bin/bash
#
# A script that creates users.
# Usage: sudo ./user_add.sh <login> <password_hash> <Name> <Surname>

set -e
user=$1
passwd_hash=$2
user_name=$3
user_surname=$4

# Checking number of arguments, script should contain 4
if [ $# -ne 4 ]; then
    echo "The script needs 4 arguments, but you had given $#"
    echo "Usage: sudo ./user_add.sh <login> <password_hash> <Name> <Surname>"
    exit 1
fi

# Checking for user exists
if grep -q "$user" /etc/passwd; then
    echo "User $user already exists"
    echo "Please choose another login"
    exit 1
fi

# Adding user
useradd -m -d /home/"$user" -p "$passwd_hash" \
    -c "$user_name $user_surname" -s /bin/bash "$user"
mkdir /home/"$user"/.ssh
touch /home/"$user"/.ssh/authorized_keys
echo "$SSHPUBKEY" >> /home/"$user"/.ssh/authorized_keys
chmod -R 700 /home/"$user"/.ssh
chmod -R 600 /home/"$user"/.ssh/authorized_keys
chown -R "$user":"$user" /home/"$user"/.ssh
