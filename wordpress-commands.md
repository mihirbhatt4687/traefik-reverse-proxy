To install wordpress

docker exec -it <wordpress_container> bash
cd /tmp && \
curl -O https://wordpress.org/latest.tar.gz && \
tar -xzf latest.tar.gz && \
cp -r wordpress/* /var/www/html/ && \
chown -R www-data:www-data /var/www/html && \
cd /var/www/html
