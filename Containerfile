FROM registry.access.redhat.com/ubi8/ubi:latest

MAINTAINER Dani <ciobomanu@yahoo.com>

LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"

ENV DOCROOT=/var/www/html

RUN yum -y update

RUN yum -y install httpd

RUN yum clean all

RUN mkdir -p /var/www/html  

RUN echo "Web server up an running" >> $DOCROOT/index.html

RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf && chgrp -R 0 /var/log/httpd /var/run/httpd && chmod -R g=u /var/log/httpd /var/run/httpd

USER 1001

EXPOSE 8080

CMD /usr/sbin/httpd -DFOREGROUND
