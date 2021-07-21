FROM registry.access.redhat.com/ubi8/ubi:8.0
MAINTAINER ANANDPAVITHRAN <apavithr@redhat.com>
LABEL "Demo of webserver"
ENV "VAR1=apple"
ENV "VAR2=grape"
EXPOSE 8080
#RUN yum install -y --no-docs --disableplugin=subscription-manager httpd
RUN yum install -y httpd && yum install net-tools -y && yum install bind-utils -y && yum install iputils -y
RUN useradd -u 1000610005 anand
RUN echo "echo \${TEST2_PORT_8080_TCP_ADDR}" >> /tmp/a.sh
RUN chmod +x /tmp/a.sh
#RUN yum clean all --disableplugin=subscription-manager -y
ADD index.html /var/www/html/
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
RUN chgrp -R 0 /var/log/httpd /var/run/httpd /var/www/html && \ 
    chmod -R g=u /var/log/httpd /var/run/httpd /var/www/html
USER anand
CMD bash -c "/usr/sbin/httpd -DFOREGROUND"

