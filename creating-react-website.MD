go to personal/

create-react-app my-new-website

make the repo. Add remote repo.

#to do

### Create on the server

## To Log onto Server
```ssh -i ./../amazon/workmac.pem ubuntu@ec2-35-178-20-119.eu-west-2.compute.amazonaws.com```

### Server
Move files to /var/www/my-new-website.com/html/


### Config nginx
Create config file: /etc/nginx/sites-available/my-new-website.com
```
server {
        listen 80;
        listen [::]:80;

        root /var/www/nongrose.com/html/client;
        index index.html index.htm index.nginx-debian.html;

        server_name nongrose.com www.nongrose.com;
        
        location / {
        proxy_pass http://172.31.16.226:3002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        }
}
```

### Config SSL
### Using Certbot

### Github webhook
config github webhook when merge to master
