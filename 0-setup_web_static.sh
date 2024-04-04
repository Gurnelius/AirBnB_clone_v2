#!/bin/bash
# Bash script that sets up your web servers for the
# deployment of web_static

# Install Nginx if not already installed
if ! [ -x "$(command -v nginx)" ]; then
  sudo apt-get update
  sudo apt-get install -y nginx
fi

# Create necessary directories if they don't exist
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create a fake HTML file for testing
sudo echo "<html>
<head>
  <title>Test Page</title>
</head>
<body>
  <h1>This is a test page</h1>
  <p>Hello, world!</p>
</body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link, delete if already exists
sudo rm -rf /data/web_static/current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ folder to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
nginx_config="
server {
    listen 80;
    listen [::]:80;

    server_name pymaster.tech;

    location /hbnb_static/ {
        alias /data/web_static/current/;
    }

    location / {
        # Handle other locations
    }
}
"

echo "$nginx_config" | sudo tee /etc/nginx/sites-available/default > /dev/null

# Restart Nginx
sudo service nginx restart

# Exit successfully
exit 0
