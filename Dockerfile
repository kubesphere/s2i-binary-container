FROM debian:buster-slim

MAINTAINER kubesphere@yunify.com


LABEL io.k8s.description="Binary File Exec" \
      io.k8s.display-name="Binary" \
      io.kubesphere.tags="builder,binary" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

ENV \
    # Path to be used in other layers to place s2i scripts into
    STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH

RUN mkdir -p /usr/libexec/s2i  /opt/app-root/src/bin

WORKDIR ${HOME}

RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
      -c "Default Application User" default && \
  chown -R 1001:0 ${APP_ROOT}

COPY ./s2i/bin /usr/libexec/s2i

USER 1001
