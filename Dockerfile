FROM richarvey/nginx-php-fpm



ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf
ADD conf/nginx-site-ssl.conf /etc/nginx/sites-available/default-ssl.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

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
