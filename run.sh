docker build -t my-ssl-apache .
mkdir uploads
chmod 777 uploads 
docker run -d -p 443:443 -v $(pwd)/uploads:/var/www/html/uploads my-ssl-apache

