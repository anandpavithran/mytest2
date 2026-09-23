FROM registry.access.redhat.com/ubi9
MAINTAINER ANANDPAVITHRAN<apavithr@redhat.com>
ENV VAR1=apple\
     VAR2=grape\
     VAR3=ibm
EXPOSE 8080
#RUN yum install -y --no-docs --disableplugin=subscription-manager httpd
RUN dnf install -y httpd && yum install net-tools -y && yum install bind-utils -y && yum install iputils && yum install sudo-1.8.29 -y 
#RUN yum clean all --disableplugin=subscription-manager -y
ADD index.html /var/www/html/
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
RUN chgrp -R 0 /var/log/httpd /var/run/httpd /var/www/html && \ 
    chmod -R g=u /var/log/httpd /var/run/httpd /var/www/html
USER 1001
CMD bash -c "/usr/sbin/httpd -DFOREGROUND"
