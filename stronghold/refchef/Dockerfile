FROM continuumio/anaconda3:latest
MAINTAINER Stronghold Help <stronghold-help@brown.edu>

COPY ./refchef /root

RUN pip install refchef
RUN conda install -c bioconda bwa salmon
