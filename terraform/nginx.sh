#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx

cat > /etc/nginx/sites-available/default << EOF
upstream app{
  server 16.171.47.221:3000 weight=40;
  server 13.50.4.183:3000 weight=30;
  server 16.171.115.172:3000 weight=20;
  server 51.20.103.103:3000 weight=10;
}
server {
  listen 80;
  
  server_name mydomain.com;

  location / {
      include proxy_params;
      
      proxy_pass http://app;
      
      proxy_redirect off;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
  }
}
EOF

sudo systemctl restart nginx

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok


curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
sudo dpkg -i cloudflared.deb && 
sudo cloudflared service install eyJhIjoiMjA1YzFkZDdiNmJlMzQ4ZTQzYTNjOGRmZDQ3NTczYjAiLCJ0IjoiMDQ1MGI0YTctN2QyNi00ZGZiLWFkMDItNGY5ZTY5OTNkY2U0IiwicyI6IlltTmlaVFpqTmpBdFpUWXpZUzAwWW1FMExXRXhNekF0TXpBNU1HVTFNRGxqWVdKaiJ9