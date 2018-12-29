# Creating my-new-website url: my-new-website.com

## Create website
### Create client and directory
* go to personal/
* create-react-app my-new-website
### Create Node Server
* cd my-new-website
* npm install express --save
* Run the following:
```
echo '
const express = require('express');
const path = require('path');
const app = express();
let portNumber = 3002;

app.use(express.static(path.join(__dirname, 'build')));

app.get(/'//', function(req, res) {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(portNumber);

' > app.js
```

* Change port number

## add the following to .gitignore
* deploy.sh
* package-lock.json

## Then
* rm package-lock.json
* npm install

## Create Repo
Make the repo on github. 
Add remote repo.

## Create on the server

### To Log onto Server
```ssh -i ~/personal/amazon/workmac.pem ubuntu@ec2-35-178-20-119.eu-west-2.compute.amazonaws.com```

### Server location
* copy files to /var/www/my-new-website.com/html/
* sudo git clone https://github.com/jackkenlay/my-new-website.git .
* git config credential.helper store
* git pull
* sudo npm install

### Config NGINX
https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04
* Create config file: /etc/nginx/sites-available/my-new-website.com
* Replace all urls
* ! If multiple servers on 1 server, then ensure the new port number isnt conflicting with any others!!
```
server {
        listen 80;
        listen [::]:80;

        root /var/www/my-new-website.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name my-new-website.com www.my-new-website.com;
        
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
* Enable Server Block:
```
sudo ln -s /etc/nginx/sites-available/my-new-website.com /etc/nginx/sites-enabled/
```
* Check nginx config files
```
sudo nginx -t
```
* Restart nginx
```
sudo systemctl restart nginx
```


### Config SSL
### Using Certbot

### Github webhook
config github webhook when merge to master

### Namecheap
go to domains -> my-new-domain.com -> advanced DNS:
```
A Record            @          my-new-ip
A Record            www          my-new-ip
```
## to Run
### Locally (using node)
```
npm start
node app.js
```
### On server
(ensuring forever is installed, npm install forever -g)
```
cd /var/www/my-new-website.com/html
sudo git pull
sudo npm install
sudo npm run build
sudo forever start app.js
```

## To Deploy
* Run the following command to create deploy.sh
```
echo '
ssh -i ~/personal/amazon/workmac.pem ubuntu@ec2-35-178-20-119.eu-west-2.compute.amazonaws.com "
echo \"logged in\"
sleep 2
echo \"changing to website directory\"
cd /var/www/nongrose.com/html/
ls
sleep 5
echo \"pulling..\"
sudo git pull
sudo git pull
echo \"pulled.\"
echo \"npm installing...\"
sudo npm install
sleep 5
echo \"done.\"
echo \"running npm build...\"
sudo npm run build
echo \"done.\"
echo \"restarting app.js.\"
sudo forever restart app.js
echo \"done.\"
echo \"logging off....\"
sleep 5
"
' > deploy.sh && echo 'NOW CHANGE THE URL'
```
* DONT FORGET to change the DIR
* bash deploy.sh
## Add to google analytics
## Add to google search console

## Development

### Add Reactstrap
```
npm install --save reactstrap react react-dom
```
