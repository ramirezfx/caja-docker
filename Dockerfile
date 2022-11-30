FROM ramirezfx/ubuntu-mate-iso:kinetic

COPY ./keyboard /etc/default/keyboard

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration && \
    localedef -i de_AT -c -f UTF-8 -A /usr/share/locale/locale.alias de_AT.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    dpkg-reconfigure --frontend noninteractive keyboard-configuration

RUN apt-get install -y caja

RUN rm -rf /var/lib/apt/lists/*

ENV QT_GRAPHICSSYSTEM="native"
ENV LC_ALL de_AT.UTF-8
ENV LANG de_AT.UTF-8
ENV LANGUAGE de_AT.UTF-8
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]
