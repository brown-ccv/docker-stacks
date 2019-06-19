FROM continuumio/anaconda3:latest
MAINTAINER Stronghold Help <stronghold-help@brown.edu>

COPY . .

RUN pip install refchef
RUN conda install -c bioconda bwa salmon
