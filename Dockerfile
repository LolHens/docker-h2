FROM lolhens/baseimage-openjre:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ENV H2_VERSION 2016-10-31
ENV H2_NAME h2
ENV H2_FILE $H2_NAME-$H2_VERSION.zip
ENV H2_URL http://www.h2database.com/$H2_FILE


RUN cd "/tmp" \
 && curl -LO $H2_URL \
 && unzip $H2_FILE \
 && chmod +x "$H2_NAME/bin/h2.sh" \
 && mv $H2_NAME "/usr/local/h2/" \
 && cleanimage

RUN appfolders add "artifactory/data" "/usr/local/artifactory/data" \
 && appfolders add "artifactory/etc" "/usr/local/artifactory/etc" \
 && appfolders add "artifactory/logs" "/usr/local/artifactory/logs" \
 && appfolders add "artifactory/backup" "/usr/local/artifactory/backup"


WORKDIR /usr/local/h2
CMD bin/h2.sh


VOLUME /usr/local/appdata/h2

EXPOSE 8082
