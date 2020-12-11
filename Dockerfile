FROM alpine:3.9

RUN apk add --no-cache bash python3 dnsmasq
RUN pip3 install requests
COPY data/entrypoint /entrypoint
RUN chmod 755 /entrypoint

COPY script/zerotier.py /mnt/scripts/zerotier.py
COPY script/update.sh /etc/periodic/1min/update.sh
RUN chmod +x /etc/periodic/1min/update.sh
RUN touch /etc/zerotier_hosts

ENV DNSMASQ_HOME /mnt/dnsmasq
WORKDIR ${DNSMASQ_HOME}
EXPOSE 53/udp

ENTRYPOINT ["/entrypoint"]
CMD ["-d", "-C", "dnsmasq.conf"]
