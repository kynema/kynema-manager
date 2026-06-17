FROM ecpe4s/ubuntu24.04-runner-x86_64-gcc-13.3:1779820030

ARG BUILD_DATE
ARG COMMIT

RUN git clone --recursive https://github.com/kynema/kynema-manager \
 && git -C kynema-manager checkout $COMMIT

ENV E4S_MACHINE=1 
ENV KYNEMA_MANAGER=/kynema-manager

WORKDIR /kynema-manager/scripts/docker-ci
RUN ["/bin/bash", "./ci-creator.sh"]

WORKDIR /
RUN apt update -y \
 && apt install -y clangd \
 && apt clean -y

RUN echo export KYNEMA_MANAGER=$KYNEMA_MANAGER >> /etc/bash.bashrc \
 && echo export E4S_MACHINE=1 >> /etc/bash.bashrc \
 && echo ". \$KYNEMA_MANAGER/start.sh" >> /etc/bash.bashrc \
 && echo spack-start >> /etc/bash.bashrc

LABEL io.e4s.build-date=${BUILD_DATE}
