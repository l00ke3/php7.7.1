FROM richarvey/nginx-php-fpm




COPY start.sh /start.sh
RUN chmod +x /start.sh

ADD src/ /var/www/html/

RUN apk add imap-dev krb5-dev
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
        && docker-php-ext-install imap \
        && docker-php-ext-enable imap

EXPOSE 443 80

WORKDIR "/var/www/html"
CMD ["/start.sh"]
