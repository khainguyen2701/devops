# Next.js Docker Compose

Đây là dự án chứa cấu hình Docker Compose để chạy ứng dụng Next.js với Nginx reverse proxy.

Trước tiên bạn cần có 1 server và có key pair để kết nối vào server.

ssh vào server và tạo các thư mục cần thiết

```bash
mkdir -p /var/www/nextjs
```

```bash
mkdir -p /var/www/nextjs/nginx/certs
```

```bash
mkdir -p /var/www/nextjs/nginx/conf.d
```

```bash
sudo apt update

sudo apt install git -y

sudo apt install docker.io -y

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

```

## Cấu hình source code

Clone source code vào thư mục /var/www/nextjs

```bash
git clone https://github.com/kyanon/nextjs.git /var/www/nextjs
```

Chạy lệnh sau để build và chạy ứng dụng

```bash
docker-compose up --build -d
```

nếu bị lỗi permission denied khi chạy lệnh trên, hãy chạy lệnh sau để cấp quyền cho user hiện tại

```bash
sudo chown -R $USER:$USER /var/www/nextjs
```

nếu bị lỗi permission cho certs hãy chạy lệnh sau để cấp quyền cho certs (owner, read, write)

```bash
sudo chmod 644 nginx/certs/nginx-selfsigned.key
sudo chmod 644 nginx/certs/nginx-selfsigned.crt
```

chạy lệnh sau để xóa hết những gì không dùng trước đó và build lại ứng dụng

```bash
docker-compose down --rmi all
docker-compose build --no-cache
docker-compose up -d
```

xin ssl cho domain của bạn
ec2 không cho chạy lệnh certbot trực tiếp, câu lệnh dưới chỉ chạy với domain thật

```bash
sudo apt install -y certbot python3-certbot-nginx letsencrypt
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

```bash
ssl_certificate /etc/letsencrypt/live/ntd0609/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/ntd0609/privkey.pem;
```
