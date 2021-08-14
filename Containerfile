ARG BASE_TAG=8

FROM docker.io/rockylinux/rockylinux:${BASE_TAG}
LABEL maintainer="Vlad Vetu"

# Enable systemd on container
ENV container=docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
      systemd-tmpfiles-setup.service ] || rm -f $i; done); \
      rm -f /lib/systemd/system/multi-user.target.wants/*;\
      rm -f /etc/systemd/system/*.wants/*;\
      rm -f /lib/systemd/system/local-fs.target.wants/*; \
      rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
      rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
      rm -f /lib/systemd/system/basic.target.wants/*;\
      rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN dnf -y update --setopt install_weak_deps=false \
  && dnf clean all \
  && rm -rf /var/cache/yum

VOLUME ["/sys/fs/cgroup"]

CMD ["/sbin/init"]