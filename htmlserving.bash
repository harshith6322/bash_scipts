#!/bin/bash

# Update package lists
yes | sudo apt update

# Install Apache2
yes | sudo apt install apache2

# Get hostname and IP address
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | cut -d' ' -f1)

# Write HTML content to index page
echo "<h1>Server Details</h1>
<p><strong>Hostname:</strong> $HOSTNAME</p>
<p><strong>IP Address:</strong> $IP_ADDRESS</p>" | sudo tee /var/www/html/index.html > /dev/null

# Restart Apache2 to apply changes
sudo systemctl restart apache2
