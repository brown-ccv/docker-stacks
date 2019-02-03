FROM openjdk:8-alpine

RUN apk update && apk add ca-certificates openssl wget unzip

## ~1.7G
RUN mkdir /opt 
RUN cd /tmp \
    && wget http://apache.osuosl.org//ctakes/ctakes-4.0.0/apache-ctakes-4.0.0-bin.tar.gz \
    && tar -xvf apache-ctakes-4.0.0-bin.tar.gz -C /opt

RUN pwd
RUN ls -la
## ~76M

# Remove dictionaries, they are synchedn and bound in stronghold since the location need to be writable

# Get dictionary files
# RUN wget https://github.com/bcbi/ctakes_dictionaries/raw/master/sno_rx_18ab.zip
# RUN unzip -o sno_rx_18ab.zip -d /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/
# RUN rm -rf /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/__MACOSX
# RUN ls /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/
# RUN wget -q -O sno_rx_18ab.xml https://github.com/bcbi/ctakes_dictionaries/raw/master/sno_rx_18ab_sh.xml
# RUN mv sno_rx_18ab.xml /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/

CMD [ "/bin/bash" ]