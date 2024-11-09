# Utilizar la imagen base de PHP con Apache
FROM php:7.4-apache

# Actualizar e instalar openssl
RUN apt-get update && apt-get install -y openssl

# Habilitar el módulo SSL en Apache
RUN a2enmod ssl

# Generar un certificado autofirmado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=ES/ST=State/L=City/O=Company/OU=Org/CN=localhost"

# Configurar Apache para usar el certificado autofirmado
RUN sed -i 's|SSLCertificateFile.*|SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt|' /etc/apache2/sites-available/default-ssl.conf && \
    sed -i 's|SSLCertificateKeyFile.*|SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key|' /etc/apache2/sites-available/default-ssl.conf

# Habilitar el sitio SSL por defecto
RUN a2ensite default-ssl

# Copiar upload.php al directorio web
COPY upload.php /var/www/html/

# Crear el directorio de cargas y establecer permisos
#RUN mkdir /var/www/html/uploads && chown www-data:www-data /var/www/html/uploads

# Exponer el puerto 443 para SSL
EXPOSE 443

# Comando para iniciar Apache en primer plano
CMD ["apache2-foreground"]

