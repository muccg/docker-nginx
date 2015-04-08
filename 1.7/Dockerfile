#
FROM nginx:1.7
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

RUN rm -rf /etc/nginx
COPY nginx /etc/nginx
RUN mkdir -p /data && chown nginx:nginx /data

VOLUME /data

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
