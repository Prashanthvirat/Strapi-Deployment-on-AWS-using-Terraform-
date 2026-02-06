#!/bin/bash
exec 2> /home/ubuntu/errors.txt

TARGET_USER="ubuntu"
APP_DIR="/home/$TARGET_USER/strapi-app"

# -----------------------------
# 1. Install dependencies
# -----------------------------
apt update -y
apt install -y curl build-essential python3 make g++ git

# -----------------------------
# 2. Install NVM
# -----------------------------
sudo -u $TARGET_USER bash -c '
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.6/install.sh | bash
'

# -----------------------------
# 3. Install Node 20 + PM2
# -----------------------------
sudo -u $TARGET_USER bash -c '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install 20
nvm alias default 20

npm install -g pm2@latest
'

# -----------------------------
# 4. Create Strapi Project
# -----------------------------
sudo -u $TARGET_USER bash -c '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd "$HOME"

echo "n" | STRAPI_TELEMETRY_DISABLED=true \
npx --yes create-strapi-app@latest strapi-app \
--quickstart --no-run --skip-cloud
'

# -----------------------------
# 5. Build & Start Strapi
# -----------------------------
sudo -u $TARGET_USER bash -c '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd "$HOME/strapi-app"

npm install
NODE_ENV=production npm run build

pm2 start npm --name "strapi-api" -- run start
pm2 save
'

# -----------------------------
# 6. Enable PM2 on reboot
# -----------------------------
sudo -u $TARGET_USER bash -c '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

pm2 startup systemd -u ubuntu --hp /home/ubuntu
'

chown $TARGET_USER:$TARGET_USER /home/$TARGET_USER/errors.txt