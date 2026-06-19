#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Take pride in how far you've come. Have faith in how far you can go, but don't forget to enjoy the journey." > /var/www/html/index.html


# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run as root (using sudo)."
  exit 1
fi

# ==========================================
# Configuration Variables
# ==========================================
USERNAME="naheemah"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCk/luAy8BopgblGkkTitHEXO36QxRn16x7vNp4dtf4X+JTK6wZiblDp/I8tt53hq13Ty9jSA4381dzNOvU7n08Bzq2VxnyG8rScHskA01Nk2Q0bKisaJtpAxNKewDgNf1w1h5JnIicjAXkws3ZUTMNlxaHq8F4hGRD4KGWIh7k6ZLlUQX6PK0evHYEbTI7trBBjhyGkalqqFv/kzf7ZA0XdzpbyHP0DyjhDO9FApzI5Y0MfYyqR6xfO/xn4sH0iCjxXH0JeDuSQdn94vKwYou8gCaLdUHlr+ecvXGs4i7PP5lF6WUhFMGepAEoFLqWtjA+Z0t1iWma0+/DYA23uAK+fb1rFyz6Qh88oHAxgNt7ZpQELWhjjkirRun5lYR+Sulr7VdjNhAhrj70RpVCSXg1vDeV/2onJHuiepBGaeE0sTHXckvESOipK0veQSWPFQ+Mz3QqmHEGAg4hE51xFtE7FXwEhUbeTBY8VLWHddgWzb2H3uIZtAuXG8PEvIiGOMs= nahee@Mac.phub.net.cable.rogers.com"
GRANT_SUDO=true # Set to false if you do not want to give the user sudo access

# ==========================================
# 1. Create the User
# ==========================================
# Check if user already exists
if id "$USERNAME" &>/dev/null; then
  echo "[*] User '$USERNAME' already exists. Updating SSH keys..."
else
  echo "[+] Creating user '$USERNAME'..."
  # -m creates the home directory, -s sets the default shell
  useradd -m -s /bin/bash "$USERNAME"
  echo "[+] User '$USERNAME' created."
fi

# ==========================================
# 2. Setup SSH Directory and Keys
# ==========================================
USER_HOME="/home/$USERNAME"
SSH_DIR="$USER_HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

# Create .ssh directory and set permissions
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Add the public key to authorized_keys
echo "$SSH_PUBLIC_KEY" >> "$AUTH_KEYS"

# Set permissions for the authorized_keys file
chmod 600 "$AUTH_KEYS"

# ==========================================
# 3. Fix Ownership
# ==========================================
# Ensure the newly created user owns their .ssh directory and files
chown -R "$USERNAME:$USERNAME" "$SSH_DIR"

# ==========================================
# 4. Grant Sudo Access (Optional)
# ==========================================
if [ "$GRANT_SUDO" = true ]; then
  echo "[+] Granting sudo privileges to $USERNAME..."
  echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USERNAME"
  chmod 440 "/etc/sudoers.d/$USERNAME"
fi

echo "[+] Setup for user '$USERNAME' completed successfully!"
