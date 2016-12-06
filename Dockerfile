FROM orboan/dcss-shellinabox-httpd
MAINTAINER Oriol Boix Anfosso <dev@orboan.com>

RUN yum update

RUN \ 
rpm -Uvh --replacepkgs https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN \
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm


RUN yum install -y php56w php56w-opcache php56w-mysql php56w-iconv php56w-mbstring php56w-curl php56w-openssl php56w-tokenizer php56w-soap php56w-ctype php56w-zip php56w-gd php56w-simplexml php56w-spl php56w-pcre php56w-dom php56w-xml php56w-intl php56w-json php56w-ldap php56w-pecl-apcu php56w-odbc php56w-pear php56w-xmlrpc php56w-snmp php56w-pdo curl

RUN yum install -y ghostscript

RUN \
cd /var/www/ && \
mkdir moodledata && \
chmod -R 755 /var/www/moodledata && \
chown -R apache:apache /var/www/moodledata

RUN \ 
cd /var/www/html && \
wget https://download.moodle.org/stable32/moodle-3.2.tgz && \
tar -xvf moodle-3.2.tgz && \
mv /var/www/html/moodle /var/www/html/vle && \
chown -R apache:apache /var/www/html/vle && \
chmod -R 755 /var/www/html/vle


# - Clean YUM caches to minimise Docker image size...
RUN \
  yum clean all && rm -rf /tmp/yum*

# default
ENV MYSQL_HOST=mysql
ENV MYSQL_DATABASE=moodle
ENV MYSQL_USER=vle_user
ENV MYSQL_PASSWORD=iaw
ENV MOODLE_URL=http://iaw.io/vle
ENV MOODLE_DATADIR=/var/www/moodledata

ADD container-files /
