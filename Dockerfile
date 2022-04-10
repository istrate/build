FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER Dani <ciobomanu@yahoo.com>

LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"

ENV DOCROOT=/var/www/html

ONBUILD COPY src/ ${DOCROOT}

RUN yum -y install --nodocs --disableplugin=subscription-manager httpd && \
    yum clean --disbaleplugin=subscription-manager all && \
    mkdir -p /var/www/html && \
    echo "Web server up an running" >> $DOCROOT/index.html && \
    sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf && chgrp -R 0 /var/log/httpd /var/run/httpd && chmod -R g=u /var/log/httpd /var/run/httpd

USER 1001

EXPOSE 8080

CMD /usr/sbin/httpd -DFOREGROUND
