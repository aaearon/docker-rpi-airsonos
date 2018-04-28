FROM arm32v7/node:4

ADD supervisord.conf /build/
ADD dbus.sh /build/

RUN /usr/sbin/usermod -u 99 nobody && \
    /usr/sbin/usermod -g 100 nobody
    
RUN apt-get update && apt-get install -y \
    supervisor \
    build-essential \
    libavahi-compat-libdnssd-dev \
    libasound2-dev

RUN mkdir -p /var/log/supervisor

RUN export USER=root && npm install -g --unsafe-perm babel@5

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN git clone https://github.com/lsmith77/airsonos && cd airsonos && export USER=root && npm install -g --unsafe-perm

RUN chmod +x /build/dbus.sh

RUN [ "cross-build-end" ]

EXPOSE 5000 5001 5002 5003 5004 5005 5006 5006 5007 5008 5009 5010 5011 5012 5013 5014 5015

CMD ["/usr/bin/supervisord"]
