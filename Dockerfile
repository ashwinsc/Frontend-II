FROM httpd:latest
WORKDIR /usr/local/apache2/htdocs
COPY ./dist /usr/local/apache2/htdocs
EXPOSE 80
CMD ["httpd-foreground"]
