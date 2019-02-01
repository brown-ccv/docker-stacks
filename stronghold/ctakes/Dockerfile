FROM openjdk:8-alpine

RUN apk update && apk add ca-certificates openssl wget unzip

## ~1.7G
RUN mkdir /opt && cd /opt
RUN wget -q -O - http://apache.osuosl.org//ctakes/ctakes-4.0.0/apache-ctakes-4.0.0-bin.tar.gz | tar xzf -

## ~76M
ADD https://github.com/bcbi/ctakes_dictionaries/blob/master/sno_rx_18ab.zip .
RUN unzip -o sno_rx_18ab.zip.zip -d apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/
ADD https://github.com/bcbi/ctakes_dictionaries/blob/master/sno_rx_18ab_sh.xml .
RUN mv sno_rx_18ab_sh.xml apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/sno_rx_18ab.xml

CMD [ "/bin/bash" ]