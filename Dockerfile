FROM richarvey/nginx-php-fpm




COPY start.sh /start.sh
RUN chmod +x /start.sh

ADD src/ /var/www/html/



EXPOSE 443 80

WORKDIR "/var/www/html"
CMD ["/start.sh"]
