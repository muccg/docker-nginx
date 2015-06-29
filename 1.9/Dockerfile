#
FROM nginx:1.9
MAINTAINER https://github.com/muccg

RUN rm -rf /etc/nginx
COPY nginx /etc/nginx
RUN mkdir -p /data && chown nginx:nginx /data

VOLUME /data

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
