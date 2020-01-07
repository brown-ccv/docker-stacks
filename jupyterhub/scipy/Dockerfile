FROM jupyter/scipy-notebook:7a0c7325e470

USER root

# Install missing systems (apt-get) tools
COPY ./scripts/install_sys_deps.sh /tmp/install_sys_deps.sh
RUN chmod +x /tmp/install_sys_deps.sh
RUN /tmp/install_sys_deps.sh

RUN ~/.nvm/nvm.sh
RUN ~/.nvm/bash_completion
RUN nvm install 12.14.0 \
RUN nvm use 12
