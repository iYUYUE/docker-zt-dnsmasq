FROM alpine:3.9

RUN touch /etc/zerotier_hosts
RUN apk add --no-cache bash python3 dnsmasq
RUN pip3 install requests
COPY data/entrypoint /entrypoint
RUN chmod 755 /entrypoint

COPY script/zerotier.py /mnt/scripts/zerotier.py
RUN mkdir -p /etc/periodic/1min && echo "*       *       *       *       *       run-parts /etc/periodic/1min" >> /etc/crontabs/root
COPY script/update.sh /etc/periodic/1min/update-zt-hosts
RUN chmod +x /etc/periodic/1min/update-zt-hosts

ENV DNSMASQ_HOME /mnt/dnsmasq
WORKDIR ${DNSMASQ_HOME}
EXPOSE 53/udp

ENTRYPOINT ["/entrypoint"]
CMD ["-d", "-C", "dnsmasq.conf"]
