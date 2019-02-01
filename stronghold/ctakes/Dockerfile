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

RUN wget https://github.com/bcbi/ctakes_dictionaries/raw/master/sno_rx_18ab.zip
RUN unzip -o sno_rx_18ab.zip -d /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/

RUN rm -rf /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/_MACOSX/

RUN wget -q -O sno_rx_18ab.xml https://github.com/bcbi/ctakes_dictionaries/raw/master/sno_rx_18ab_sh.xml

RUN mv sno_rx_18ab.xml /opt/apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup/fast/

CMD [ "/bin/bash" ]


# # get cTAKES
# RUN wget http://mirror.cogentco.com/pub/apache/ctakes/ctakes-4.0.0/apache-ctakes-4.0.0-bin.tar.gz && \
#     tar -xvf apache-ctakes-4.0.0-bin.tar.gz -C /usr/local

# # get UMLS resources
# RUN cd /tmp && \
#     wget https://sourceforge.net/projects/ctakesresources/files/ctakes-resources-4.0-bin.zip && \
#     unzip ctakes-resources-4.0-bin.zip
# RUN cp -R /tmp/resources/* /usr/local/apache-ctakes-4.0.0/resources