FROM nginx:alpine
COPY ./html/index.html /usr/share/nginx/html/
COPY ./html/style.css /usr/share/nginx/html/
